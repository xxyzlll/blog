<template>
  <el-card class="about-card">
    <h2>关于作者</h2>
    <el-divider />
    <div class="about-content">
      <el-avatar :size="100" />
      <div class="bio-text">
        <h3>技术栈</h3>
        <el-tag
          v-for="tag in ['Vue', 'TypeScript', 'Node.js']"
          :key="tag"
          type="info"
          class="tag-margin"
        >
          {{ tag }}
        </el-tag>
      </div>
    </div>
  </el-card>
</template>

<style scoped>
.about-card {
  max-width: 800px;
  margin: 20px auto;
}
.bio-text {
  margin-top: 20px;
}
.tag-margin {
  margin: 0 5px;
}
</style>