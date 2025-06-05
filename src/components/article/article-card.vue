<template>
  <div class="article-card">
    <!-- 背景图片区域 -->
    <div class="image-container" @click="toDetail">
      <el-image
          :alt="data.title"
          :src="data.imageUrl"
          fit="cover"
          class="background-image">
        <template #placeholder>
          <img
              src="@/assets/learn/outload.svg"
              class="background-image"
          >
        </template>
      </el-image>
      <!-- 左上角：发布时间 -->
      <div class="publish-date">
        <el-icon>
          <Calendar/>
        </el-icon>
        <span>发布于{{ formattedDate }}</span>
      </div>
      <!-- 右上角：元信息 -->
      <div class="meta-info">
        <div class="meta-item">
          <el-icon>
            <Document/>
          </el-icon>
          <span>{{ data.wordCount }}字</span>
        </div>
        <div class="meta-item" v-for="tag in data.tag" :key="tag">
          <el-icon>
            <Folder/>
          </el-icon>
          <span>{{ tag }}</span>
        </div>
      </div>
    </div>

    <!-- 文章描述 -->
    <div class="content">
      <h3 class="title">{{ data.title }}</h3>
      <p>{{ data.description }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps, computed } from 'vue'
import { Calendar, Document, Folder } from '@element-plus/icons-vue'
import { useRouter } from "vue-router";

const router = useRouter()

// 定义组件属性
const { data } = defineProps({
  data: {
    type: Object,
    required: true,
    default: () => ({
      imageUrl: '',
      title: '',
      description: '',
      publishDate: '',
      tag: '',
      wordCount: 0,
    })
  }
})
// 处理日期格式
const formattedDate = computed(() => {
  // 实际项目中可以使用dayjs进行格式化
  return data.publishDate
})

function toDetail() {
  router.push('/article-detail?data=' + JSON.stringify(data))
}


</script>

<style scoped>
.article-card {
  width: 100%;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  background: #fff;
  transition: transform 0.3s;
  margin-bottom: 40px;
}

.article-card:hover {
  transform: translateY(-5px);
}

.image-container {
  position: relative;
  width: 100%;
  height: 180px;
  overflow: hidden;
}

.background-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.background-image:hover {
  height: 100%;
  transform: scale(1.1);
}

.publish-date {
  position: absolute;
  top: 10px;
  left: 10px;
  background: rgba(255, 255, 255, 0.8);
  padding: 5px 10px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #606266;
}

.publish-date .el-icon {
  margin-right: 5px;
}

.meta-info {
  position: absolute;
  top: 10px;
  right: 10px;
  display: flex;
  gap: 10px;
}

.meta-item {
  background: rgba(255, 255, 255, 0.8);
  padding: 3px 8px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #606266;
}

.meta-item .el-icon {
  margin-right: 5px;
}

.content {
  padding: 35px 15px 20px;
  position: relative;

  .title {
    position: absolute;
    top: -30px;
    background: rgba(220, 212, 212, 0.74);
    padding: 10px 15px;
    border-radius: 6px;
    color: #505050;
  }
}

.content h3 {
  margin: 5px 0 8px;
  font-size: 18px;
  font-weight: 600;
  color: #303133;
}

.content p {
  margin: 0;
  font-size: 14px;
  color: #606266;
  line-height: 1.5;
  display: -webkit-box;
  text-indent: 2em;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
