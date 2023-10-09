<template>
  <HeaderBar />
  <div class="app">
    <SidebarNav />
    <router-view />
  </div>
  <FooterBar />
</template>

<script setup>
  import HeaderBar from '@/components/HeaderBar.vue'
  import SidebarNav from '@/components/SidebarNav.vue'
  import FooterBar from '@/components/FooterBar.vue'
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

.app {
  display: flex;
  background-color: #5a5a5a;

  main {
    flex: 1 1 0;
    padding: 2rem;
  }
}
</style>
