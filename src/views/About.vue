<template>
  <div>
    <el-card class="about-card">
      <div class="header-section">
        <img src="@/assets/me/avatar.jpg"/>
        <div class="header-info">
          <h1>前端开发工程师</h1>
          <el-tag effect="dark" type="success">4年开发经验</el-tag>
        </div>
      </div>

      <el-divider/>

      <el-timeline>
        <el-timeline-item
            v-for="(exp, index) in workExperience"
            :key="index"
            :timestamp="exp.period"
            placement="top"
        >
          <el-card class="experience-card">
            <h3 class="blur-text">{{ exp.company }}</h3>
            <el-tag
                v-for="(tag, tagIndex) in exp.tags"
                :key="tagIndex"
                :type="['primary','success','info'][tagIndex%3]"
                class="tag-margin"
            >
              {{ tag }}
            </el-tag>
            <ul class="experience-list">
              <li v-for="(item, itemIndex) in exp.items" :key="itemIndex">
                {{ item }}
              </li>
            </ul>
          </el-card>
        </el-timeline-item>
      </el-timeline>

      <el-collapse v-model="activeNames" class="skill-collapse">
        <el-collapse-item name="1">
          <template #title>
            <el-icon>
            </el-icon>
            <span class="collapse-title">核心技术栈</span>
          </template>
          <div class="skill-tags">
            <el-tag
                v-for="(skill, index) in skills"
                :key="index"
                :type="index%2 ? 'info' : 'success'"
                effect="light"
                class="skill-tag"
            >
              {{ skill }}
            </el-tag>
          </div>
        </el-collapse-item>
      </el-collapse>

      <!--    <el-divider />-->
      <!--    <h3>教育背景</h3>-->
      <!--    <div class="education-section">-->
      <!--      <el-icon><location /></el-icon>-->
      <!--      <span>广东东软学院 · 软件工程 · 统招本科（2017-2021）</span>-->
      <!--    </div>-->

      <el-collapse v-model="activeProject" class="project-collapse">
        <el-collapse-item name="2">
          <template #title>
            <el-icon>
            </el-icon>
            <span class="collapse-title">重点项目经验</span>
          </template>

          <el-carousel :interval="5000" height="580px" type="card">
            <el-carousel-item v-for="(project, index) in projects" :key="index">
              <el-card class="project-card">
                <div class="project-header">
                  <h3>{{ project.title }}</h3>
                  <el-tag effect="dark" type="warning">{{ project.role }}</el-tag>
                </div>
                <div class="project-desc">{{ project.desc }}</div>
                <el-divider/>

                <div class="tech-stack">
                  <el-tag
                      v-for="(tech, techIndex) in project.techStack"
                      :key="techIndex"
                      type="info"
                      effect="light"
                      class="tech-tag"
                  >
                    {{ tech }}
                  </el-tag>
                </div>

                <el-timeline class="project-timeline">
                  <el-timeline-item
                      v-for="(item, itemIndex) in project.highlights"
                      :key="itemIndex"
                      placement="top"
                      :timestamp="item.title"
                  >
                    <ul class="highlight-list">
                      <li v-for="(desc, descIndex) in item.items" :key="descIndex">
                        {{ desc }}
                      </li>
                    </ul>
                  </el-timeline-item>
                </el-timeline>

                <!--              <el-divider/>-->
                <!--              <div class="project-results">-->
                <!--                <el-icon>-->
                <!--                  <trophy/>-->
                <!--                </el-icon>-->
                <!--                <span>{{ project.results }}</span>-->
                <!--              </div>-->
              </el-card>
            </el-carousel-item>
          </el-carousel>
        </el-collapse-item>
      </el-collapse>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'

const activeNames = ref(['1'])
const activeProject = ref(['2'])

const workExperience = reactive([{
  company: '精创芯国科技有限公司',
  period: '2024.03 - 至今',
  tags: ['React', '大屏', 'AI中台'],
  items: [
    '主导OA低代码平台架构设计，实现开发效率提升40%',
    '构建政企研生态圈AI中台，支持RAG应用与Agent工作流',
    '落地WebSocket视频流低延迟传输方案（<200ms）'
  ]
}, {
  company: '鱼爪集团',
  period: '2022.02 - 2023.12',
  tags: ['Vue3', 'Nuxt js', 'AIGC'],
  items: [
    '制定新版前端研发规范，统一集团技术栈',
    '开发全链路监控SDK，系统可用性达99.99%',
    '封装中台通用AIGC SDK，支持快速接入'
  ]
}, {
  company: '广州蜂芒网络科技有限公司',
  period: '2020.06 - 2022.02',
  tags: [],
  items: [
    '驱动 Vue3+TS 架构升级，推进组合式 API 落地',
    '多端研发覆盖，H5/小程序/RN 跨平台适配'
  ]
}])

const skills = reactive([
  'TypeScript', 'React/Vue', 'RN/Uniapp',
  'Webpack/Vite', 'Node.js', 'Dify', '性能调优'
])

const projects = reactive([{
  title: '园区智改平台',
  role: '前端开发',
  desc: '构建政府-园区-企业三级联动智改数转体系，整合经济运行、安全态势等 12 类全域数据，实现数据可视、AI 预警、处置闭环。通过 LLM 大模型赋能安全生产与移动办公，助力企业降本 30%+、关键工序数控化率达 92%',
  techStack: ['React', 'Uniapp', 'Dify', 'WebSocket'],
  highlights: [{
    title: '技术创新',
    items: [
      '大模型流式响应优化',
      '视频流延迟<200ms',
      '多端通信协议统一'
    ]
  }, {
    title: '业务价值',
    items: [
      '关键工序数控化率92%',
      '企业运维成本降低30%',
      'AI预警响应速度提升40%'
    ]
  }],
  results: '入选省级数字化转型示范项目'
}, {
  title: '集团风控系统',
  role: '前端负责人',
  desc: '公司战略级风控平台，主要风控集团资金、员工行为和敏感信息等，对接数十个中台系统。独立完成包含模型设置、指标构建、风险排行榜、资金风险、黑白名单、SDK 抽离、线上错误日志等全部模块功能开发',
  techStack: ['React', 'Umi', 'Antd', 'Webpack'],
  highlights: [{
    title: '核心功能',
    items: [
      'SDK抽离与性能监控',
      '源映射错误定位系统',
      '多中台对接解决方案'
    ]
  }, {
    title: '技术突破',
    items: [
      'SDK初始化成功率99.99%',
      '错误日志定位效率提升70%',
      '性能指标采集精度±2%'
    ]
  }],
  results: '累计减少企业损失近百万元'
}, {
  title: '麦汇知识产权业务线产品改版',
  role: '前端开发',
  desc: '麦汇业务线产品支援，负责对多端产品进行样式改版和 API 替换，以提升用户体验和优化网站性能',
  techStack: ['Vue', 'Nuxt.js', 'Vite'],
  highlights: [{
    title: '核心功能',
    items: [
      '通用组件封装，rollup 打包并完成单测和文档产出',
      'Vite 替换 Vue-Cli',
      '性能调优、SEO 优化'
    ]
  }, {
    title: '技术突破',
    items: [
      '40%的需求工时由 5h 降低到 1h',
      '降低项目 80% 启动时间，打包时间节省约 35%',
      '网站自然流量增长 60%',
      '大幅提升了 LCP、TBT，降低 FCP 指标'
    ]
  }],
  results: '累计减少企业损失近百万元'
},])

</script>

<style scoped lang="less">
.about-card {
  max-width: 800px;
  padding: 30px;
  margin: 80px auto 20px;
}

.header-section {
  display: flex;
  align-items: center;
  gap: 40px;
  margin-bottom: 30px;

  img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
  }
}

.header-info h1 {
  margin: 0 0 15px 0;
  font-size: 2.2em;
  color: #2c3e50;
}

.experience-card {
  margin: 15px 0;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);

  .tag-margin {
    margin-right: 10px;
  }

}

.blur-text {
  -webkit-user-select: none; /* Safari/Chrome */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+ */
  user-select: none; /* 标准语法 */

  color: transparent; /* 隐藏原文字 */
  text-shadow: 0 0 8px rgba(0, 0, 0, 0.9);

  //color: transparent; /* 隐藏原文字 */
  //text-shadow: 0 0 12px rgba(0, 0, 0, 0.9); /* 模糊半径越大越难辨认 */


  //filter: blur(8px); /* 值越大越模糊 */
  //-webkit-filter: blur(8px);
}

.experience-list {
  padding-left: 20px;

  li {
    margin: 10px 0;
    color: #666;
    line-height: 1.6;
  }
}

.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 10px;
  padding: 0 20px;
}

.skill-tag {
  font-size: 1.1em;
  padding: 8px 15px;
  border-radius: 15px;
}

.collapse-title {
  margin-left: 10px;
  font-weight: bold;
}

.education-section {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 1.1em;
  color: #409EFF;
}


.project-collapse {
  margin-top: 40px;
}

.project-card {
  height: 520px;
  padding: 20px;
  background: linear-gradient(145deg, #f8f9fa, #ffffff);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border-radius: 12px;
}

.project-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.project-desc {
  text-indent: 2em;
}

.tech-stack {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin: 20px 0;
}

.tech-tag {
  font-size: 0.9em;
  padding: 6px 12px;
  border-radius: 12px;
}

.highlight-list {
  padding-left: 20px;

  li {
    margin: 12px 0;
    color: #444;
    line-height: 1.5;
    position: relative;

    &::before {
      content: '●';
      color: #409EFF;
      position: absolute;
      left: -15px;
    }
  }
}

.project-results {
  display: flex;
  align-items: center;
  gap: 10px;
  color: #67C23A;
  font-weight: 500;
  padding: 15px;
  background: rgba(103, 194, 58, 0.1);
  border-radius: 8px;
}

:deep(.el-carousel__item) {
  padding: 20px;
  transform: scale(0.9);
  transition: all 0.3s;

  &.is-active {
    transform: scale(1);
  }
}
</style>
