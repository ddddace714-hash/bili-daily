<template>
  <div class="nav">
    <div class="logo">B站关注日报</div>
    <div class="date">{{ today }}</div>
    <el-button size="small" @click="$emit('refresh')">刷新</el-button>
  </div>
</template>

<script setup>
const today = new Date().toLocaleDateString("zh-CN");
</script>

<style scoped>
.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 60px;
  background: #00a1d6;
  padding: 0 20px;
  color: white;
}
.logo {
  font-size: 20px;
  font-weight: bold;
}
</style>