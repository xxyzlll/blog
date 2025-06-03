<template>
  <div class="friend-links">
    <el-card>
      <template #header>
        <div class="card-header">
          友情链接
        </div>
      </template>
      <el-space direction="vertical">
        <div v-for="i in 5" :key="i" class="link-item">
          <el-link type="primary">示例友链 {{ i }}</el-link>
        </div>
      </el-space>
    </el-card>
  </div>
</template>

<style scoped>
.friend-links {
  max-width: 800px;
  margin: 20px auto;
}
.link-item {
  padding: 8px 0;
}
</style>