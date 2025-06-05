<template>
  <div class="article-detail-container">
    <div class="article-detail-content">
      <div class="article-detail-header">
        <h1>{{ article.title }}</h1>
        <div class="author-info">
          <img src="@/assets/me/avatar.jpg" alt="作者头像" class="author-avatar">
          <div class="author-name">yyyzl</div>
          <div class="publish-date">发布于 {{ article.publishDate }}</div>
        </div>
      </div>

      <div class="summary-card">
        {{ article.description }}
      </div>

      <div class="markdown-body" ref="markdownRef" v-html="markdownContent"></div>
    </div>

    <!--    <div class="toc-container" :class="{ 'toc-collapsed': isTocCollapsed }">-->
    <!--      <el-button-->
    <!--          @click="isTocCollapsed=!isTocCollapsed"-->
    <!--          size="small"-->
    <!--          :icon="isTocCollapsed ? 'ArrowRight' : 'ArrowLeft'"-->
    <!--      >-->
    <!--        {{ isTocCollapsed ? '' : '收起目录' }}-->
    <!--      </el-button>-->
    <!--      <div v-show="!isTocCollapsed" class="toc-content"></div>-->
    <!--    </div>-->
  </div>
</template>

<script setup>
import {ref, onMounted, nextTick} from 'vue'
import {useRoute} from 'vue-router'
import MarkdownIt from 'markdown-it'
import hljs from 'highlight.js'
import 'highlight.js/styles/github-dark.css'

const route = useRoute()
const article = ref({})
const markdownContent = ref('')
const markdownRef = ref(null)

// 初始化Markdown解析器
const md = new MarkdownIt({
  html: true,
  linkify: true,
  typographer: true,
  highlight: (str, lang) => {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return `<pre class="hljs"><code>${hljs.highlight(str, {language: lang}).value}</code></pre>`
      } catch (__) {
      }
    }
    return ''
  }
})

onMounted(() => {
  try {
    const data = route.query.data
    article.value = JSON.parse(data)
    console.log(JSON.parse(data))
    loadMarkdownContent()
  } catch (__) {
  }
})

async function loadMarkdownContent() {
  try {
    const response = await fetch(article.value.mdPath)
    const text = await response.text()
    markdownContent.value = md.render(text)

    // 渲染后生成目录
    nextTick(generateTOC)
  } catch (error) {
    console.error('加载Markdown失败:', error)
  }
}

function generateTOC() {
  const tocContent = document.querySelector('.toc-content')
  if (!tocContent || !markdownRef.value) return

  const headers = markdownRef.value.querySelectorAll('h1, h2, h3')

  if (!headers.length) {
    tocContent.innerHTML = '<div class="toc-empty">无目录内容</div>'
    return
  }

  tocContent.innerHTML = ''
  headers.forEach(header => {
    const level = parseInt(header.tagName.substring(1))
    const id = header.textContent.replace(/\s+/g, '-').toLowerCase()
    header.id = id

    const tocItem = document.createElement('div')
    tocItem.className = 'toc-item'
    tocItem.style.paddingLeft = `${(level - 1) * 12}px`
    tocItem.innerHTML = `<a href="#${id}">${header.textContent}</a>`

    tocContent.appendChild(tocItem)
  })
}
</script>

<style scoped>
/* 整体布局 */
.article-detail-container {
  display: flex;
  padding: 80px 20px 0;
  max-width: 860px;
  position: relative;
  margin: 0 auto 0;
}

.article-detail-content {
  flex: 1;
  padding-right: 20px;
}

/* 标题和作者信息 */
.article-detail-header h1 {
  font-weight: 700;
  font-size: 28px;
  margin-bottom: 20px;
  text-align: center;
}

.author-info {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

.author-avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  margin-right: 5px;
}

.author-name {
  transform: translateY(-1px);
  font-weight: 600;
}

.publish-date {
  font-size: 14px;
  color: #666;
  margin-left: 10px;
}

/* 摘要卡片 */
.summary-card {
  background: #f8f9fa;
  border-left: 4px solid #e9ecef;
  padding: 16px;
  border-radius: 4px;
  margin-bottom: 24px;
  color: #495057;
  font-size: 15px;
  line-height: 1.6;
}

/* Markdown内容样式 */
.markdown-body {
  line-height: 1.75;
  font-size: 16px;
}

/* 目录样式 */
.toc-container {
  position: fixed;
  top: 20px;
  right: calc((100% - 860px) / 2);
  width: 240px;
  background: white;
  border: 1px solid #eaeaea;
  border-radius: 4px;
  padding: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  transition: all 0.3s;
  max-height: 85vh;
  overflow: hidden;
}

.toc-container.toc-collapsed {
  width: 40px;
  padding: 8px;
}

.toc-content {
  margin-top: 12px;
  max-height: calc(85vh - 60px);
  overflow-y: auto;
}

.toc-item {
  padding: 6px 0;
  border-bottom: 1px solid #f0f0f0;
}

.toc-item a {
  color: #495057;
  text-decoration: none;
  font-size: 14px;
  display: block;
  transition: all 0.2s;
}

.toc-item a:hover {
  color: #1890ff;
}

/* 移动端适配 */
@media (max-width: 768px) {
  .article-detail-container {
    flex-direction: column;
    padding: 0 15px;
  }

  .toc-container {
    position: static;
    width: 100%;
    margin-top: 20px;
    right: auto;
  }

  .toc-container.toc-collapsed {
    height: 40px;
    width: 100%;
  }
}
</style>
