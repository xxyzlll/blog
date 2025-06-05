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

const baseList = [
  {
    tag: '技术',
    description: '这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件...',
    publishDate: '2024-11-22',
    mdPath:'/markdown/浏览器工作原理.md',
    wordCount: 1500,
    category: '前端开发'
  }, {
    tag: '技术',
    description: '这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件...',
    publishDate: '2024-11-22',
    mdPath:'/markdown/浏览器工作原理.md',
    wordCount: 1500,
    category: '前端开发'
  }, {
    tag: '技术',
    description: '这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件...',
    publishDate: '2024-11-22',
    mdPath:'/markdown/浏览器工作原理.md',
    wordCount: 1500,
    category: '前端开发'
  }, {
    tag: '技术',
    description: '这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件...',
    publishDate: '2024-11-22',
    wordCount: 1500,
    mdPath:'/markdown/浏览器工作原理.md',
    category: '前端开发'
  }, {
    tag: '技术',
    description: '这是一篇关于Vue3组件开发的文章，详细介绍了如何创建可复用的卡片组件...',
    publishDate: '2024-11-22',
    mdPath:'/markdown/浏览器工作原理.md',
    wordCount: 1500,
    category: '前端开发'
  }]

const list = ref(baseList.map(data => {
  return {
    ...data,
    id: window.crypto.randomUUID(),
    imageUrl: randomImgUrl(baseList.length + 20)
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
