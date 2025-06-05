<template>
  <div class="tags-container">
    <el-card>
      <el-space direction="horizontal">
        <div v-for="(i,idx) in customTags" :key="i" class="tag-item">
          <el-tag :type="tagType[idx % 3]" size="large" @click="toList(i)">{{ i }}</el-tag>
        </div>
      </el-space>
    </el-card>
  </div>
</template>
<script setup lang="ts">
import { customTags } from "@/contants";
import { useRouter } from "vue-router";

const tagType = ["primary", "success", "warning"]

const router = useRouter()

function toList(tag: string) {
  router.push('/articles?tag=' + tag)
}
</script>
<style scoped lang="less">
.tags-container {
  max-width: 800px;
  margin: 80px auto;
  min-height: calc(100vh - 200px);

  .tag-item {
    cursor: pointer;
    margin-right: 5px;
  }
}

</style>
