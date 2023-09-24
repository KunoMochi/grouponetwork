<template>
    <div class="forum">
        <div class="post-button">
            <button>Create a Post</button>
        </div>
        <h1>This is the Forum page</h1>
        <CommentBox class="comment-box"/>
    </div>
</template>

<script setup>
    import CommentBox from '../components/CommentBox.vue'
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

        button {
            font-weight: bold;
            padding: .5rem;
        }
    }
</style>
  