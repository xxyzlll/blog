<template>
  <div class="article-container">
    <article-card v-for="item in list" :data="item" :key="item.id"/>
  </div>
</template>

<script setup lang="ts">
// 后续可添加表格数据

import { ref } from "vue";
import ArticleCard from "@/components/article/article-card.vue";
import { randomImgUrl } from "@/utils";
import { baseList } from "@/contants/article.ts";

const list = ref(baseList.map(data => {
  return {
    ...data,
    id: window.crypto.randomUUID(),
    imageUrl: randomImgUrl(baseList.length + 120)
  }
}))

</script>

<style>
.article-container {
  max-width: 860px;
  padding: 80px 20px 0;
  margin-left: auto;
  margin-right: auto;
  background-color: transparent !important;
}
</style>
