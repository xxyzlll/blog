<template>
  <div class="tags-container">
    <el-card class="card-hover-effect">
      <!-- 分类筛选头部 -->
      <div class="filter-header">
        <div class="filter-controls">
          <el-select
              v-model="selectedCategory"
              placeholder="选择分类"
              clearable
              class="category-select"
          >
            <el-option
                v-for="category in categories"
                :key="category.value"
                :label="category.label"
                :value="category.value"
            />
          </el-select>
        </div>
        <div class="category-tags">
          <el-tag
              v-for="category in categories"
              :key="category.value"
              :type="categoryTypes[category.value % 3]"
              :class="['category-tag', { 'active': selectedCategory === category.value }]"
              size="medium"
              effect="dark"
              @click="selectCategory(category.value)"
          >
            {{ category.label }}
          </el-tag>
        </div>
      </div>

      <!-- 卡片视图 -->
      <div class="tags-grid">
        <div
            v-for="(i, idx) in filteredSites"
            :key="i.url"
            class="tag-card"
            :style="{
            '--tag-color': tagColors[idx % 3],
            '--tag-hover-color': tagHoverColors[idx % 3]
          }"
            @click="openSite(i.url)"
        >
          <el-tag class="tag-effect" size="large">
            <el-icon :size="18" style="margin-right: 8px">
              <component :is="tagIcons[idx % 3]"/>
            </el-icon>
            {{ i.title }}
          </el-tag>
          <p class="tag-description">{{ i.subTitle }}</p>
          <div class="category-indicator">
            <el-tag size="small" :type="categoryTypes[i.category % 3]">
              {{ getCategoryLabel(i.category) }}
            </el-tag>
          </div>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";
import { Star, Link, View } from "@element-plus/icons-vue";


// 分类定义
const categories = ref([
  { value: 0, label: "全部" },
  { value: 1, label: "AI工具" },
  { value: 2, label: "科学上网" },
  { value: 3, label: "资源导航" },
  { value: 4, label: "流量卡代理" },
  { value: 5, label: "开发者工具" },
  { value: 6, label: "我的项目" }
]);

const categoryTypes = ["primary", "success", "warning"];
const selectedCategory = ref(0);

// 使用自定义颜色方案
const tagColors = ["#4a6cf7", "#a855f7", "#10b981"];
const tagHoverColors = ["#3b5be0", "#8d4cd9", "#0da271"];
const tagIcons = [Star, Link, View];

// 网站数据（添加分类字段）
const sites = ref([
  {
    url: 'https://various-resources-abigl6ehv-xxyzllls-projects.vercel.app/',
    title: '资源收藏',
    subTitle: '发现探索优质资源',
    category: 3 // 资源导航
  },
  {
    url: 'https://ai.dangbei.com/chat/350883972270129541',
    title: '当贝AI',
    subTitle: '聚合全网优质大模型服务',
    category: 1 // AI工具
  },
  {
    url: 'https://kokk.cn/#/dashboard',
    title: 'Free Cloud',
    subTitle: '免费科学上网',
    category: 2 // 科学上网
  },
  {
    url: 'https://fly.mzkxz.top/user',
    title: '喵子科学站',
    subTitle: '免费科学上网',
    category: 2 // 科学上网
  },
  {
    url: 'https://ym.kashijiehaoka.cn/invite?s=qQv2slE6403090',
    title: '卡世界代理',
    subTitle: '代理出售多运营商平台流量卡',
    category: 4 // 流量卡代理
  },
  {
    url: 'https://gantanhao.vip/91haoka_platform/#/register?supplier_id=DLvl0cGan9',
    title: '敢探号代理',
    subTitle: '代理出售多运营商平台流量卡',
    category: 4 // 流量卡代理
  },
  {
    url: 'https://github.com',
    title: 'GitHub',
    subTitle: '全球开发者社区',
    category: 5 // 开发者工具
  },
  {
    url: 'https://openai.com',
    title: 'OpenAI',
    subTitle: '人工智能研究实验室',
    category: 1 // AI工具
  },
  {
    url: `${window.location.origin}/wxapp`,
    title: '心意动',
    subTitle: '谈个恋爱吧（微信小程序搜索心意动访问～）',
    category: 6 // 我的项目
  },
]);

// 筛选后的网站列表
const filteredSites = computed(() => {
  if (selectedCategory.value === 0) return sites.value;
  return sites.value.filter(site => site.category === selectedCategory.value);
});

// 获取分类标签
const getCategoryLabel = (categoryValue: number) => {
  const category = categories.value.find(cat => cat.value === categoryValue);
  return category ? category.label : '未知';
};

// 选择分类
const selectCategory = (category: number) => {
  selectedCategory.value = category;
};

function openSite(url: string) {
  window.open(url);
}
</script>

<style scoped lang="less">
.tags-container {
  max-width: 1200px;
  margin: 80px auto;
  min-height: calc(100vh - 200px);
  padding: 0 20px;

  // 卡片悬停动画
  .card-hover-effect {
    border-radius: 16px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
    border: none;
    padding: 24px;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
    }
  }

  // 筛选头部样式
  .filter-header {
    margin-bottom: 28px;
    border-bottom: 1px solid #f0f0f0;
    padding-bottom: 16px;

    .filter-controls {
      display: flex;
      justify-content: space-between;
      margin-bottom: 16px;
      gap: 12px;

      .category-select {
        flex: 1;
        max-width: 220px;
      }

      .tag-mode-button {
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;

        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 10px rgba(74, 108, 247, 0.25);
        }
      }
    }

    .category-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 8px;

      .category-tag {
        cursor: pointer;
        transition: all 0.3s ease;
        border-radius: 6px;
        font-weight: 500;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);

        &:hover {
          transform: translateY(-3px);
          box-shadow: 0 5px 12px rgba(0, 0, 0, 0.12);
        }

        &.active {
          transform: scale(1.05);
          font-weight: 600;
          box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
      }
    }
  }

  /deep/ .el-tag__content {
    display: flex;
    align-items: center;
  }

  // 卡片网格样式
  .tags-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 24px;
    padding: 0 10px;

    .tag-card {
      position: relative;
      background: white;
      border-radius: 12px;
      padding: 24px;
      transition: all 0.3s ease;
      border: 1px solid #f1f1f1;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
      cursor: pointer;
      overflow: hidden;

      &:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);

        .tag-effect {
          background: var(--tag-hover-color);
          transform: scale(1.05);
        }
      }

      .category-indicator {
        position: absolute;
        top: 15px;
        right: 15px;
        opacity: 0.9;
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

    .tag-description {
      color: #4b5563;
      font-size: 0.95rem;
      line-height: 1.5;
      margin-top: 12px;
      min-height: 42px;
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .tags-container {
    margin: 30px auto;
    padding: 0 15px;

    .filter-header {
      .filter-controls {
        flex-direction: column;

        .category-select {
          max-width: 100%;
        }
      }

      .category-tags {
        gap: 8px;
        overflow-x: auto;
        padding-bottom: 8px;

        .category-tag {
          font-size: 0.85rem;
          padding: 6px 12px;
        }
      }
    }

    .tags-grid {
      grid-template-columns: 1fr;
      padding: 0;
      gap: 18px;

      .tag-card {
        padding: 20px;
      }
    }
  }
}

@media (max-width: 480px) {
  .tags-container {
    .filter-header {
      .category-tags {
        gap: 6px;
      }
    }
  }
}
</style>
