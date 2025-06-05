<template>
  <div class="article-card">
    <!-- 背景图片区域 -->
    <div class="image-container">
      <img
          :src="data.imageUrl"
          :alt="data.title"
          class="background-image"
      >
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
        <div class="meta-item">
          <el-icon>
            <Folder/>
          </el-icon>
          <span>{{ data.category }}</span>
        </div>
      </div>
    </div>

    <!-- 标签区域 -->
    <div class="tag-container">
      <el-tag type="info" size="small">{{ data.tag }}</el-tag>
    </div>

    <!-- 文章描述 -->
    <div class="content">
      <h3>{{ data.title }}</h3>
      <p>{{ data.description }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps, computed, onMounted, ref } from 'vue'
import { Calendar, Document, Folder } from '@element-plus/icons-vue'

// 定义组件属性
const props = defineProps({
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
      category: ''
    })
  }
})
const markdownContent = ref('')
// 处理日期格式
const formattedDate = computed(() => {
  // 实际项目中可以使用dayjs进行格式化
  return props.data.publishDate
})

onMounted(async () => {
  const response = await fetch('/markdown/浏览器工作原理.md');
  markdownContent.value = await response.text();
  console.log(' markdownContent.value', markdownContent.value)
});

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
  min-height: 270px;
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
  flex-direction: column;
  align-items: flex-end;
  gap: 5px;
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

.tag-container {
  padding: 10px 15px 5px;
}

.content {
  padding: 0 15px 15px;
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
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
