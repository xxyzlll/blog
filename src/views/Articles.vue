<template>
  <div class="article-container">
    <article-card v-for="item in list" :data="item" :key="item.id"/>
  </div>
</template>

<script setup lang="ts">
// 后续可添加表格数据

import { ref, watch } from "vue";
import ArticleCard from "@/components/article/article-card.vue";
import { randomImgUrl } from "@/utils";
import { baseList } from "@/contants/article.ts";
import type { Article } from "@/types";
import { useRoute } from "vue-router";

const list = ref<Article[]>([])
const tag = ref<string>('')

const route = useRoute()
tag.value = route.query.tag as string

function getList() {
  const baseLength = baseList.length;
  const imgSeed = baseLength + 120;
  const currentTag = tag.value;

  list.value = baseList.reduce((acc: Article[], data: Article) => {
    if (currentTag && !data.tag.includes(currentTag)) return acc;

    acc.push({
      ...data,
      id: window.crypto.randomUUID(),
      imageUrl: randomImgUrl(imgSeed)
    });
    return acc;
  }, []);
}

watch(() => route.path, init, { immediate: true, deep: true })

function init() {
  tag.value = route.query.tag as string
  getList()
}

init()
</script>

<style scoped lang="less">
.article-container {
  max-width: 860px;
  padding: 80px 20px 0;
  margin-left: auto;
  margin-right: auto;
  background-color: transparent !important;
  min-height: calc(100vh - 120px);
}
</style>
