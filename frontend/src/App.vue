
import SidebarComp from './components/SidebarComp.vue';
<template>
  <div class="app">
    <SideBarNav />
    <!-- <nav>
      <router-link to="/">Home</router-link> |
      <router-link to="/forum">Forum</router-link> |
      <router-link to="/about">About</router-link> |
      <router-link to="/contact">Contact</router-link> | 
      <router-link to="/signup">Sign Up</router-link> | 
      <router-link to="/login">Login</router-link>
    </nav> -->
    <router-view />
  </div>
</template>

<script setup>
  import SideBarNav from '@/components/SideBarNav.vue'
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.app {
  display: flex;
}

nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
