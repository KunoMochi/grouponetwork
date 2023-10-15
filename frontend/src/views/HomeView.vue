<template>
  <div class="home">
    <h1>Welcome to the GroupoNetwork!</h1>
    <!-- <img alt="Vue logo" src="../assets/logo.png"> -->
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <CommentBox class="commentBox"/>
  </div>
</template>

<script setup>
    import CommentBox from '../components/CommentBox.vue'
</script>

<script>
// @ is an alias to /src
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: 'HomeView',
  // components: {
  //   HelloWorld
  // }
}
</script>

<style lang="scss" scoped>
  .home {
    padding: 1rem;
  }

  h1 {
    text-align: center;
  }

  div {
    width: 100%;
    padding: 1rem;
  }

  .commentBox {
    margin: 1rem;
  }
</style>
