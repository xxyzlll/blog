<template>
  <div>
    <div class="home-container">
      <div class="user position-center">
        <img src="@/assets/me/avatar.jpg"/>
        <div>
          <p>
            <span>“</span>
            <span ref="typewriterText" class="typewriter-text"></span>
            <span class="blinking-cursor"></span>
            <span>”</span>
          </p>
          <p>yyyl</p>
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
import { ref, onMounted, onUnmounted } from 'vue'

const typewriterText = ref<HTMLSpanElement | null>(null)
const text = "undefined"
    // || "落日熔尽最后一块金锭，群山便典当了影子"
let currentIndex = 0
let timer: number | null = null

onMounted(() => {
  startTypewriterEffect()
})

onUnmounted(() => {
  stopTypewriterEffect()
})

const startTypewriterEffect = () => {
  if (!typewriterText.value) return

  timer = setInterval(() => {
    if (currentIndex < text.length) {
      if (typewriterText.value) {
        typewriterText.value.textContent += text.charAt(currentIndex)
      }
      currentIndex++
    } else {
      stopTypewriterEffect()
    }
  }, 150) as unknown as number
}

const stopTypewriterEffect = () => {
  if (timer) {
    clearInterval(timer)
    timer = null
  }
}
</script>

<style scoped lang="less">
.home-container {
  background: url("https://api.maho.cc/random-img/pc.php") 50% 50%;
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
        display: flex;
        justify-content: center;
        align-items: center;

        span:first-child, span:last-child {
          margin: 0 5px;
        }
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
      background-size: auto 100%; /* 保持原始高度自适应 */
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

/* 打字机效果样式 */
.typewriter-text {
  display: inline-block;
  overflow: hidden;
  white-space: nowrap;
  letter-spacing: 0.15em;
}

.blinking-cursor {
  display: inline-block;
  width: 2px;
  height: 1em;
  background-color: currentColor;
  margin-left: 1px;
  animation: blink 1s infinite;
  vertical-align: middle;
}

@keyframes blink {
  0%, 50% {
    opacity: 1;
  }
  51%, 100% {
    opacity: 0;
  }
}
</style>
