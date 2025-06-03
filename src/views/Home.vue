<template>
  <el-card class="box-card">
    <template #header>
      <div class="card-header">
<!--        <span>欢迎来到我的博客</span>-->
      </div>
    </template>
    <div v-for="o in 224" :key="o">
      {{  o }}
    </div>
  </el-card>
</template>

<script setup lang="ts">
// 后续可添加数据逻辑
</script>

<style scoped>
.box-card {
  max-width: 800px;
  margin: 20px auto;
}
</style>
