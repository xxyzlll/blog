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

  </div>
</template>

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
</style>
<script setup lang="ts">
</script>
