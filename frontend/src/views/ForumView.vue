<template>
    <div class="forum">
        <h1>Recent Topics</h1>
        <router-link class="postLink" to="/post">Create a Post</router-link>
        <CommentBox class="comment"/>
    </div>
</template>

<script setup>
    import CommentBox from '@/components/CommentBox.vue'
</script>

<style lang="scss" scoped>
    .forum {
        width: 100%;
        text-align: left;
        padding: 1rem;
    }

    .postLink {
        padding: 5px;
        background-color: #474747;
        text-align: left;
        font-size: large;
    }

    .postLink:hover {
        background-color: #3b3b3b;
    }

    .comment {
        margin: 1rem;
    }
</style>
  