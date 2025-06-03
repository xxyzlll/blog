<template>
  <div class="article-container">
    <el-input
      placeholder="搜索文章"
      class="search-input"
      clearable
    />
    <el-table :data="[]" style="width: 100%">
      <el-table-column prop="title" label="标题" />
      <el-table-column prop="date" label="发布日期" width="180" />
    </el-table>
  </div>
</template>

<script setup lang="ts">
// 后续可添加表格数据
</script>

<style>
.search-input {
  margin-bottom: 20px;
  max-width: 300px;
}
</style>