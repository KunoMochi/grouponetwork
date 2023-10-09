<template>
    <div class="post">
        <h1>Start a New Topic</h1>
        <CommentBox class="post-box"/>
    </div>
</template>

<script setup>
    import CommentBox from '@/components/PostBox.vue'
</script>

<style lang="scss" scoped>
    .post{
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .post-box {
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