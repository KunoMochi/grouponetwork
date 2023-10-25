<template>
  <HeaderBar />
  <div class="app">
    <SidebarNav />
    <router-view :key="$route" />
  </div>
  <FooterBar />
</template>

<script setup>
  import HeaderBar from '@/components/HeaderBar.vue'
  import SidebarNav from '@/components/SidebarNav.vue'
  import FooterBar from '@/components/FooterBar.vue'
</script>

<script>
export default {
  mounted() {
    document.title = 'GroupoNetwork'
  }
}
</script>

<style lang="scss">
:root {
  --sidebar-width: 300px;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: white;
}

a {
  font-weight: bold;
  text-decoration: none;
  color: white;
}

a:hover {
  text-decoration: underline;
}

.app {
  display: flex;
  background-color: #5a5a5a;
}
</style>
