这段源码的作用是处理 Vue 3 响应式系统中的依赖收集和追踪，其中需要注意的是重置追踪状态的位运算操作：

    dep.w &= ~trackOpBit 
    dep.n &= ~trackOpBit

这两行代码使用了位运算符来清除 dep.w 和 dep.n 中的特定位。 <br> <br>
首先，我们需要了解 trackOpBit 的作用。trackOpBit 是一个整数，它的二进制表示中只有一个位被设置为 1。例如，trackOpBit 可能是 0b00001000（十进制中的 8）。在这个例子中，我们关注的是第 4 位（从右向左数）。<br><br>
使用了按位与（&）和按位非（\~）运算符。按位与运算符将两个数字的每一位进行与操作，只有当两个位都为 1 时，结果的对应位才为 1。按位非运算符将一个数字的每一位取反，即 0 变为 1，1 变为 0
\~trackOpBit 将 trackOpBit 的每一位取反。例如，如果 trackOpBit 是 0b00001000，那么 \~trackOpBit 就是 0b11110111。

然后将 dep.w（或 dep.n）与 \~trackOpBit 进行按位与操作。这将清除 dep.w（或 dep.n）中的特定位（即 trackOpBit 中设置为 1 的位）。例如，如果 dep.w 是 0b00101010，那么 dep.w &= \~trackOpBit 将使 dep.w 变为 0b00100010，即清除了第 4 位。

这两行代码的目的是清除 dep.w 和 dep.n 中的特定位，以便在下一次追踪操作时重新设置这些位。这是一种高效的位操作技巧，用于处理追踪状态。

在这里使用位运算而不是直接赋值的原因是效率和灵活性。位运算是一种高效的操作，因为它们直接操作二进制位，而不需要进行任何类型转换或其他额外操作。此外，位运算可以在不影响其他位的情况下修改特定位，这使得它们非常适合用于处理具有多个独立标志位的变量。

在这里dep.w 和 dep.n 可能包含其他标志位，这些位在清除 trackOpBit 对应的位时需要保持不变。通过使用位运算，可以确保只修改关心的位，而不影响其他位

源码路径：packages/reactivity/src/dep.ts

    // 依赖集合相关方法，用于收集和管理响应式数据的依赖
    import { ReactiveEffect, trackOpBit } from './effect'

    export type Dep = Set<ReactiveEffect> & TrackedMarkers

    /**
     * wasTracked and newTracked maintain the status for several levels of effect
     * tracking recursion. One bit per level is used to define whether the dependency
     * was/is tracked.
     */
    type TrackedMarkers = {
      /**
       * wasTracked
       */
      // 已追踪
      w: number
      /**
       * newTracked
       */
      // 新追踪
      n: number
    }

    // 创建一个新的 Dep 实例。它接受一个可选的 ReactiveEffect 数组作为参数，并将其转换为 Dep 类型
    export const createDep = (effects?: ReactiveEffect[]): Dep => {
      const dep = new Set<ReactiveEffect>(effects) as Dep
      dep.w = 0
      dep.n = 0
      return dep
    }

    // 检查给定的 Dep 是否已经被追踪
    export const wasTracked = (dep: Dep): boolean => (dep.w & trackOpBit) > 0

    // 检查给定的 Dep 是否是新追踪的
    export const newTracked = (dep: Dep): boolean => (dep.n & trackOpBit) > 0

    // 初始化依赖项标记。它遍历 ReactiveEffect 的 deps 数组，并将每个依赖项的 w 属性设置为已追踪
    export const initDepMarkers = ({ deps }: ReactiveEffect) => {
      if (deps.length) {
        for (let i = 0; i < deps.length; i++) {
          deps[i].w |= trackOpBit // set was tracked
        }
      }
    }

    // 处理依赖项标记
    // 遍历 ReactiveEffect 的 deps 数组
    // 同时，清除依赖项的 w 和 n 属性的位
    export const finalizeDepMarkers = (effect: ReactiveEffect) => {
      const { deps } = effect
      if (deps.length) {
        let ptr = 0
        for (let i = 0; i < deps.length; i++) {
          const dep = deps[i]
          // 如果一个依赖项已追踪且不是新追踪的，那么从依赖项中删除该效果
          if (wasTracked(dep) && !newTracked(dep)) {
            dep.delete(effect)
          } else {
            deps[ptr++] = dep
          }
          // clear bits
          dep.w &= ~trackOpBit // 1
          dep.n &= ~trackOpBit // 1
        }
        deps.length = ptr
      }
    }


