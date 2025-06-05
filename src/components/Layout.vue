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
          :icon="ArrowUp"
          @click="scrollToTop"
          @mousedown="startScroll('up')"
          @mouseup="stopScroll"
          @mouseleave="stopScroll"
      />
      <el-button
          class="scroll-btn bottom"
          :icon="ArrowDown"
          @click="scrollToBottom"
          @mousedown="startScroll('down')"
          @mouseup="stopScroll"
          @mouseleave="stopScroll"
      />
    </div>
  </div>
</template>
<script setup lang="ts">
import { ArrowUp, ArrowDown } from '@element-plus/icons-vue'
import { onUnmounted, ref } from 'vue'

const isScrolling = ref(false)
const scrollDirection = ref('')
let scrollInterval: number | null = null

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const scrollToBottom = () => {
  window.scrollTo({ top: document.documentElement.scrollHeight, behavior: 'smooth' })
}

const startScroll = (direction: string) => {
  scrollDirection.value = direction
  isScrolling.value = true
  smoothScroll()
}

const smoothScroll = () => {
  if (!isScrolling.value) return

  const step = scrollDirection.value === 'up' ? -80 : 80
  window.scrollBy({ top: step, behavior: 'smooth' })

  scrollInterval = requestAnimationFrame(smoothScroll)
}

const stopScroll = () => {
  isScrolling.value = false
  if (scrollInterval) {
    cancelAnimationFrame(scrollInterval)
    scrollInterval = null
  }
}

// 清理动画帧
onUnmounted(() => {
  stopScroll()
})
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
  background: #fff; /* 背景色根据需要调整 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 可选：添加轻微阴影替代边框 */
  height: 30px; /* 与原始菜单高度一致 */
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
  color: #606266;
  font-size: 14px;
  transition: color 0.3s;

  /* 移除所有边框 */
  border: none !important;
  padding: 0 20px;
  border-radius: 30px;
}

.custom-nav a:hover {
  color: #409eff;
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

  :deep(svg) {
    width: 1.5em;
    height: 1.5em;
  }

  &:hover {
    transform: scale(1.1);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
  }

  &.bottom {
  }
}
</style>
