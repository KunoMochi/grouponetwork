<template>
    <div class="forum">
        <h1>Recent Topics</h1>
        <div class="post-button">
            <router-link to="/post">Create a Post</router-link>
        </div>
        <CommentBox class="comment-box"/>
    </div>
</template>

<script setup>
    import CommentBox from '@/components/CommentBox.vue'
</script>

<style lang="scss" scoped>
    .forum{
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .comment-box {
        position: absolute;
        width: 80%;
        background-color: #474747;
        padding: 1rem;
    }

    .post-button {
        text-align: left;
        margin: 1rem;

        a {
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
    }
</style>
  