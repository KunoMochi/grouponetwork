<template>
    <div class="post">
        <h1>Create Post</h1>
        <CommentBox class="postBox"/>
    </div>
</template>

<script setup>
    import CommentBox from '@/components/PostBox.vue'
</script>

<style lang="scss" scoped>
    .post{
        width: 100%;
        text-align: left;
        padding: 1rem;
    }

    .postBox {
        margin: 1rem;
    }
</style>