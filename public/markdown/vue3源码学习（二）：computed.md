#### 路径：packages/reactivity/src/computed.ts
附详细注释

````
import { DebuggerOptions, ReactiveEffect } from './effect'
import { Ref, trackRefValue, triggerRefValue } from './ref'
import { isFunction, NOOP } from '@vue/shared'
import { ReactiveFlags, toRaw } from './reactive'
import { Dep } from './dep'

declare const ComputedRefSymbol: unique symbol

export interface ComputedRef<T = any> extends WritableComputedRef<T> {
  readonly value: T
  [ComputedRefSymbol]: true
}

export interface WritableComputedRef<T> extends Ref<T> {
  readonly effect: ReactiveEffect<T>
}

export type ComputedGetter<T> = (...args: any[]) => T
export type ComputedSetter<T> = (v: T) => void

export interface WritableComputedOptions<T> {
  get: ComputedGetter<T>
  set: ComputedSetter<T>
}

// Vue 3 中计算属性的实现。它定义了计算属性的基本行为，包括依赖收集、缓存、触发更新等
export class ComputedRefImpl<T> {
  // 存储计算属性的依赖关系
  public dep?: Dep = undefined

  // 存储计算属性的当前值
  private _value!: T
  // 存储计算属性的副作用函数。这个副作用函数在 计算属性的依赖 发生变化时会被触发
  public readonly effect: ReactiveEffect<T>

  // 此对象是一个 ref 类型
  public readonly __v_isRef = true
  // 计算属性是否为只读
  public readonly [ReactiveFlags.IS_READONLY]: boolean = false

  // 计算属性的值是否需要重新计算
  public _dirty = true
  // 计算属性的值是否可以被缓存
  public _cacheable: boolean

  constructor(
    getter: ComputedGetter<T>,
    private readonly _setter: ComputedSetter<T>,
    isReadonly: boolean,
    isSSR: boolean
  ) {
    // 将 getter 函数和一个回调函数传入。
    // 这个回调函数会在 计算属性的依赖发生变化 时被触发，将 _dirty 标记设置为 true，并触发计算属性的更新
    this.effect = new ReactiveEffect(getter, () => {
      if (!this._dirty) {
        this._dirty = true
        triggerRefValue(this)
      }
    })
    this.effect.computed = this
    this.effect.active = this._cacheable = !isSSR
    this[ReactiveFlags.IS_READONLY] = isReadonly
  }

  get value() {
    const self = toRaw(this)
    trackRefValue(self)
    // 当 计算属性需要重新计算 或者 计算属性不可缓存 时，重新计算计算属性的值，并将 _dirty 设置为 false
    if (self._dirty || !self._cacheable) {
      self._dirty = false
      self._value = self.effect.run()!
    }
    return self._value
  }

  set value(newValue: T) {
    this._setter(newValue)
  }
}

/**
 * Takes a getter function and returns a readonly reactive ref object for the
 * returned value from the getter. It can also take an object with get and set
 * functions to create a writable ref object.
 *
 * @example
 * ```js
 * // Creating a readonly computed ref:
 * const count = ref(1)
 * const plusOne = computed(() => count.value + 1)
 *
 * console.log(plusOne.value) // 2
 * plusOne.value++ // error
 * ```
 *
 * ```js
 * // Creating a writable computed ref:
 * const count = ref(1)
 * const plusOne = computed({
 *   get: () => count.value + 1,
 *   set: (val) => {
 *     count.value = val - 1
 *   }
 * })
 *
 * plusOne.value = 1
 * console.log(count.value) // 0
 * ```
 *
 * @param getter - Function that produces the next value.
 * @param debugOptions - For debugging. See {@link https://vuejs.org/guide/extras/reactivity-in-depth.html#computed-debugging}.
 * @see {@link https://vuejs.org/api/reactivity-core.html#computed}
 */

// 这段代码导出了多个 computed 函数，主要是为了提供不同的函数重载，以便于在不同的使用场景下提供更好的类型推断和代码提示。
// 这里使用了重載的方式，这里有两种重要的重载

// 1.只有一个 getter 函数的只读计算属性
export function computed<T>(
  getter: ComputedGetter<T>,
  debugOptions?: DebuggerOptions
): ComputedRef<T>
// 2.有 get 和 set 函数的可写计算属性 ---> WritableComputedOptions
export function computed<T>(
  options: WritableComputedOptions<T>,
  debugOptions?: DebuggerOptions
): WritableComputedRef<T>

// 在实际的 computed 函数实现中，根据传入的参数类型（getterOrOptions）来判断是只读计算属性还是可写计算属性。
// 如果传入的是一个函数（isFunction(getterOrOptions) 返回 true），则认为是只读计算属性，否则认为是可写计算属性。
// 然后根据这个判断来设置 getter 和 setter 函数，并创建一个 ComputedRefImpl 实例
export function computed<T>(
  getterOrOptions: ComputedGetter<T> | WritableComputedOptions<T>,
  debugOptions?: DebuggerOptions,
  isSSR = false
) {
  let getter: ComputedGetter<T>
  let setter: ComputedSetter<T>

  const onlyGetter = isFunction(getterOrOptions)
  // 用户只提供了一个 getter 函数，这是一个只读计算属性
  if (onlyGetter) {
    getter = getterOrOptions
    // 设置一个只在开发环境下的 setter 函数，用于在尝试修改只读计算属性时发出警告
    // 在生产环境下，setter 为一个空操作（NOOP）
    setter = __DEV__
      ? () => {
          console.warn('Write operation failed: computed value is readonly')
        }
      : NOOP
  } else {
    // 用户提供了一个包含 get 和 set 函数的对象，这是一个可写计算属性
    getter = getterOrOptions.get
    setter = getterOrOptions.set
  }

  const cRef = new ComputedRefImpl(getter, setter, onlyGetter || !setter, isSSR)

  // 如果处于开发环境（__DEV__ 为 true），且提供了 debugOptions，并且不是在 SSR 环境下运行
  if (__DEV__ && debugOptions && !isSSR) {
    // 在调试过程中追踪和触发计算属性的依赖关系
    cRef.effect.onTrack = debugOptions.onTrack
    cRef.effect.onTrigger = debugOptions.onTrigger
  }

  return cRef as any
}

````
