<template>
  <div>
    <div class="home-container">
      <div class="user position-center">
        <img src="@/assets/me/avatar.jpg"/>
        <div>
          <p>
            <span>“</span>
            给时光以生命，给岁月以文明
            <span>”</span>
          </p>
          <p>xx</p>
        </div>
      </div>


      <div class="wave">
        <div class="wave1"/>
        <div class="wave2"/>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
// 后续可添加数据逻辑
</script>

<style scoped lang="less">
.home-container {
  background: url("@/assets/home/bg2.webp") 100% 100%;
  width: 100%;
  height: 100vh;
  position: relative;

  .user {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;

    img {
      width: 120px;
      height: 120px;
      border-radius: 50%;
    }

    div {
      text-align: center;
      background: rgba(255, 255, 255, 0.7);
      border-radius: 20px;
      padding: 10px 30px;

      span {
        font-weight: 900;
      }

      p {
        margin: 0;
      }
    }
  }

  .wave {
    width: 100%;
    overflow-x: hidden;
    position: absolute;
    height: 80px;
    bottom: 0;

    div {
      position: absolute;
      width: 100%;
      height: 80px;

      background-repeat: repeat-x; /* 关键：水平重复 */
      background-size: auto 100%;  /* 保持原始高度自适应 */
    }

    .wave1 {
      background: url("@/assets/home/wave1.png");
      animation: waveScroll 10s linear infinite;
    }


    .wave2 {
      background: url("@/assets/home/wave2.png") repeat-x;
      animation: waveScroll2 10s linear infinite;
    }

    @keyframes waveScroll {
      0% {
        background-position-x: 0;
      }
      100% {
        background-position-x: 100vw; /* 滚动一个视窗宽度 */
      }
    }
    @keyframes waveScroll2 {
      0% {
        background-position-x: 160px;
      }
      100% {
        background-position-x: 100vw; /* 滚动一个视窗宽度 */
      }
    }
  }
}


</style>
