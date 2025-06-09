<template>
  <div class="tags-container">
    <el-card class="card-hover-effect">
      <div class="tags-grid">
        <div
            v-for="(i, idx) in sites"
            :key="i.url"
            class="tag-card"
            :style="{
            '--tag-color': tagColors[idx % 3],
            '--tag-hover-color': tagHoverColors[idx % 3]
          }"
            @click="openSite(i.url)"
        >
          <el-tag
              class="tag-effect"
              size="large"
          >
            <!-- 添加图标增强视觉 -->
            <el-icon :size="18" style="margin-right: 8px">
              <component :is="tagIcons[idx % 3]"/>
            </el-icon>
            {{ i.title }}
          </el-tag>
          <!-- 添加副标题 -->
          <p class="tag-description">{{ i.subTitle }}</p>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { Star, Link, View } from "@element-plus/icons-vue";

// 使用自定义颜色方案替代预设type
const tagColors = ["#4a6cf7", "#a855f7", "#10b981"];
const tagHoverColors = ["#3b5be0", "#8d4cd9", "#0da271"];
const tagIcons = [Star, Link, View];

const sites = ref([
  {
    url: 'https://various-resources-abigl6ehv-xxyzllls-projects.vercel.app/',
    title: '资源收藏',
    subTitle: '发现探索优质资源'
  },
  {
    url: 'https://ai.dangbei.com/chat/350883972270129541',
    title: '当贝AI',
    subTitle: '聚合全网优质大模型，为你提供极速、免费、不限量的大模型服务'
  },
  { url: 'https://kokk.cn/#/dashboard', title: 'Free Cloud', subTitle: '免费科学上网' },
  { url: 'https://fly.mzkxz.top/user', title: '喵子科学站', subTitle: '免费科学上网' },
  { url: 'https://ym.kashijiehaoka.cn/invite?s=qQv2slE6403090', title: '卡世界代理', subTitle: '代理出售多运营商平台流量卡' },
  { url: 'https://gantanhao.vip/91haoka_platform/#/register?supplier_id=DLvl0cGan9', title: '敢探号代理', subTitle: '代理出售多运营商平台流量卡' },
]);

function openSite(url: string) {
  window.open(url);
}
</script>

<style scoped lang="less">
.tags-container {
  max-width: 1000px;
  margin: 80px auto;
  min-height: calc(100vh - 200px);
  padding: 0 20px;

  // 卡片悬停动画
  .card-hover-effect {
    border-radius: 16px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
    border: none;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
    }
  }

  .tags-header {
    text-align: center;
    margin-bottom: 36px;

    .title-gradient {
      font-size: 2.5rem;
      font-weight: 700;
      background: linear-gradient(120deg, #4a6cf7, #a855f7);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 12px;
    }

    .subtitle {
      color: #6b7280;
      font-size: 1.1rem;
      max-width: 500px;
      margin: 0 auto;
    }
  }

  .tags-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 24px;
    padding: 0 20px;

    .tag-card {
      background: white;
      border-radius: 12px;
      padding: 24px;
      transition: all 0.3s ease;
      border: 1px solid #f1f1f1;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
      cursor: pointer;

      &:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);

        .tag-effect {
          background: var(--tag-hover-color);
          transform: scale(1.05);
        }
      }
    }

    .tag-effect {
      display: inline-flex;
      align-items: center;
      padding: 12px 24px;
      border-radius: 10px;
      background: var(--tag-color);
      color: white;
      font-weight: 600;
      font-size: 1.1rem;
      transform: translateZ(0);
      transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
      border: none;
      cursor: pointer;
      margin-bottom: 15px;
      box-shadow: 0 4px 12px rgba(var(--tag-color-rgb), 0.2);
    }

    /deep/ .el-tag__content {
      display: flex;
      align-items: center;
    }

    .tag-description {
      color: #4b5563;
      font-size: 0.95rem;
      line-height: 1.5;
      margin-top: 12px;
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .tags-container {
    margin: 40px auto;

    .tags-grid {
      grid-template-columns: 1fr;
      padding: 0;

      .tag-card {
        padding: 20px;
      }
    }

    .tags-header {
      .title-gradient {
        font-size: 2rem;
      }
    }
  }
}
</style>
