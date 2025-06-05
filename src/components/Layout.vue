<template>
  <div>
    <div class="fixed-bar">
      <div class="custom-nav">
        <router-link to="/">首页</router-link>
        <router-link to="/articles">Learning</router-link>
        <router-link to="/about">关于我</router-link>
        <router-link to="/friends">友链</router-link>
      </div>
    </div>
    <router-view/>

    <footer class="custom-nav-foot">
      Theme Sakurairo by x
    </footer>

    <div class="scroll-buttons">
      <el-button
          class="scroll-btn top"
          @click="scrollToTop"
          :icon="ArrowUp"
      />

      <el-button
          class="scroll-btn bottom"
          @click="scrollToBottom"
          :icon="ArrowDown"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ArrowUp, ArrowDown } from '@element-plus/icons-vue'
import { ref } from 'vue'

const isScrolling = ref(false);
// const scrollDirection = ref('');
// const scrollInterval = ref<number | null>(null);

// 平滑滚动到顶部（点击功能）
const scrollToTop = () => {
  if (isScrolling.value) return
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

// 平滑滚动到底部（点击功能）
const scrollToBottom = () => {
  if (isScrolling.value) return
  window.scrollTo({ top: document.documentElement.scrollHeight, behavior: 'smooth' });
}

// // 开始滚动（长按功能）
// const startScroll = (e: any, direction: string) => {
//   e.stopPropagation()
//   e.preventDefault()
//   scrollDirection.value = direction;
//   isScrolling.value = true;
//
//   // 使用固定步长匀速滚动（100px/次）
//   const step = direction === 'up' ? -100 : 100;
//
//   // 立即执行第一次滚动
//   window.scrollBy({ top: step, behavior: 'smooth' });
//
//   // 设置固定间隔的滚动（300ms/次）
//   scrollInterval.value = setInterval(() => {
//     window.scrollBy({ top: step, behavior: 'smooth' });
//   }, 300) as unknown as number;
// }

// // 停止滚动
// const stopScroll = () => {
//   console.log('stopScroll')
//
//   // 清除滚动定时器
//   if (scrollInterval.value !== null) {
//     clearInterval(scrollInterval.value);
//     scrollInterval.value = null;
//   }
// }

// const scrollLeave = () => {
//   isScrolling.value = false;
//   console.log('scrollLeave')
// }
// 组件卸载时清理资源
// onUnmounted(() => {
//   stopScroll();
// });
</script>

<style scoped>
.fixed-bar {
  position: fixed;
  top: 10px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 99;
}

.custom-nav {
  display: flex;
  justify-content: center;
  background: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  height: 30px;
  line-height: 30px;
  width: fit-content;
  padding: 10px 20px;
  border-radius: 20px;
}

.custom-nav-foot {
  text-align: center;
  color: rgba(0, 0, 0, 0.3);
  transition: 0.2s ease-in-out;
}

.custom-nav a {
  height: 100%;
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #00009f;
  font-size: 14px;
  transition: color 0.3s;
  border: none !important;
  padding: 0 20px;
  border-radius: 30px;
}

.custom-nav a:hover {
  color: #00009f;
  font-weight: bold;
  background: #bee0ff;
  position: relative;
}

.custom-nav a.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 20%;
  height: 2px;
  background: #409eff;
}

.scroll-buttons {
  position: fixed;
  right: 40px;
  bottom: 40px;
  z-index: 999;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 15px;
}

.scroll-btn {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
  transform: translateZ(0); /* 启用硬件加速 */
  will-change: transform; /* 提示浏览器提前优化 */

  :deep(svg) {
    width: 1.5em;
    height: 1.5em;
  }

  &:hover {
    transform: scale(1.1);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
  }

  &.top {
    animation: floatTop 2s infinite ease-in-out;
  }

  &.bottom {
    animation: floatBottom 2s infinite ease-in-out;
  }
}

@keyframes floatTop {
  0%, 100% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(-5px) scale(1.05);
  }
}

@keyframes floatBottom {
  0%, 100% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(5px) scale(1.05);
  }
}
</style>
