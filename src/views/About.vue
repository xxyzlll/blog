<template>
  <el-card class="about-card">
    <h2>关于我</h2>
    <el-divider/>
    <div class="about-content">
      <img src="@/assets/me/avatar.jpg"/>
      <div class="bio-text">
        <h3>技术栈</h3>

        <div class="tags">
          <el-tag
              v-for="tag in tags"
              :key="tag"
              type="info"
              class="tag-margin"
          >
            {{ tag }}
          </el-tag>
        </div>
      </div>
    </div>
  </el-card>
</template>
<script setup lang="ts">
// 后续可添加数据逻辑
import { ref } from "vue";

const tags = ref(['Vue', 'TypeScript', 'React', 'React Native', 'Uni app', 'Node.js'])
</script>
<style scoped lang="less">
.about-card {
  max-width: 800px;
  margin: 80px auto 20px;

  .about-content {
    display: flex;
    flex-direction: column;
    align-items: center;

    img {
      width: 100px;
      height: 100px;
      border-radius: 50%;
    }
  }
}

.bio-text {
  margin-top: 20px;
  text-align: center;

  .tags {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    max-width: 600px;
  }
}

.tag-margin {
  margin: 0 5px;
}
</style>
