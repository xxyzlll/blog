#### 源码目录：packages/reactivity/src/deferredComputed.ts

    // 延迟计算的 Computed Ref，它在需要时才会计算值。
    // 当需要计算属性的值时，它会执行 getter 函数并缓存结果。
    // 当依赖的值发生变化时，它会异步触发更新，从而提高性能。同时，它还会通知依赖它的其他计算属性进行更新

    // 用于异步调度的promise
    const tick = /*#__PURE__*/ Promise.resolve()
    // 任务队列，存储待执行的任务
    const queue: any[] = []
    // 是否加入任务队列，避免重复添加
    let queued = false

    // 添加任务到任务队列，并在适当时机执行的调度器
    const scheduler = (fn: any) => {
      queue.push(fn)
      if (!queued) {
        queued = true
        // 下个事件循环执行 flush 函数
        tick.then(flush)
      }
    }

    const flush = () => {
      for (let i = 0; i < queue.length; i++) {
        queue[i]()
      }
      queue.length = 0
      queued = false
    }

    class DeferredComputedRefImpl<T> {
      // 依赖，用于存储依赖此计算属性的其他计算属性
      public dep?: Dep = undefined

      // 存储计算属性的值
      private _value!: T
      // 是否需要重新计算
      private _dirty = true
      // 响应式副作用，用于执行 getter 函数并在值变化时触发更新
      public readonly effect: ReactiveEffect<T>

      // 标记为 Ref，表示这是一个 Ref 类型的对象
      public readonly __v_isRef = true
      // 标记为只读，表示这个对象不可修改
      public readonly [ReactiveFlags.IS_READONLY] = true

      constructor(getter: ComputedGetter<T>) {
        // 用于比较的目标值
        let compareTarget: any
        // 标记是否有比较目标值
        let hasCompareTarget = false
        // 标记是否已经调度更新
        let scheduled = false

        // 创建响应式副作用，传入 getter 函数和调度器
        this.effect = new ReactiveEffect(getter, (computedTrigger?: boolean) => {
          // 如果存在依赖
          if (this.dep) {
            // 如果是计算属性触发的更新
            if (computedTrigger) {
              // 将当前值设置为比较目标值
              compareTarget = this._value
              // 标记有比较目标值
              hasCompareTarget = true
            }
            // 如果没有调度更新
            else if (!scheduled) {
              // 获取要比较的值
              const valueToCompare = hasCompareTarget ? compareTarget : this._value
              // 标记已经调度更新
              scheduled = true
              // 重置比较目标值标记
              hasCompareTarget = false
              scheduler(() => {
                // 如果副作用仍然激活且值发生变化 触发更新
                if (this.effect.active && this._get() !== valueToCompare) {
                  triggerRefValue(this)
                }
                // 重置调度标记
                scheduled = false
              })
            }
            // chained upstream computeds are notified synchronously to ensure
            // value invalidation in case of sync access; normal effects are
            // deferred to be triggered in scheduler.
            // 通知上游计算属性
            for (const e of this.dep) {
              // 依赖项是延迟计算的 Computed Ref
              if (e.computed instanceof DeferredComputedRefImpl) {
                // 通知依赖项更新
                e.scheduler!(true /* computedTrigger */)
              }
            }
          }
          // 标记需要重新计算
          this._dirty = true
        })
        // 将当前实例设置为副作用的计算属性
        this.effect.computed = this as any
      }

      // 获取计算属性的值
      private _get() {
        // 如果需要重新计算
        if (this._dirty) {
          // 重置标记
          this._dirty = false
          // 执行副作用并更新值
          return (this._value = this.effect.run()!)
        }
        // 返回当前值
        return this._value
      }

      // 访问计算属性的值
      get value() {
        // 追踪依赖
        trackRefValue(this)
        // the computed ref may get wrapped by other proxies e.g. readonly() #3376
        // 获取原始值，避免被其他代理包装，例如 readonly()
        return toRaw(this)._get()
      }
    }

    export function deferredComputed<T>(getter: () => T): ComputedRef<T> {
      return new DeferredComputedRefImpl(getter) as any
    }

```
```
