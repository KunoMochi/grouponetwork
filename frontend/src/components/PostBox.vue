<template>
    <form class="commentBox" v-on:submit.prevent="onSubmit({ userId, title, content, timestamp})">
        <div class="commentHead">
            <p class="title">Title</p>
            <input v-model="title" class="titlebox" placeholder="Enter a title"/>
        </div>
        <div class="commentArea">
            <p class="title">Message</p>
            <textarea v-model="content" class="textbox" autocorrect="on" placeholder="Enter a comment"></textarea>
        </div>
        <div class="formButton">
            <button class="postButton">Post Thread</button>
        </div>
        <div class="error">
            <p>{{ errorMessage }}</p>
        </div>
    </form>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
    data() {
        return {
            title: this.title,
            content: this.content,
            timestamp: Date()
        }
    },
    computed: {
        ...mapState(['userId','errorMessage']),
        ...mapGetters(['getIsAuth','getUserId'])
    },
    methods: {
        ...mapActions(['getAllTopics', 'postComment', 'resetPage']),
        onSubmit({userId, title, content, timestamp}) {
            this.postComment({userId, title, content, timestamp}).then(() => {
                this.$router.push('/forum')
            }).catch(err => {
                console.log(err)
            })
        }
    },
    beforeRouteLeave() {
        this.resetPage()
        this.getAllTopics()
    }
}
</script>

<style lang="scss" scoped>
    .commentBox {
        max-width: 1000px;
        background-color: #474747;
        padding: 01rem;
    }

    .commentHead, .commentArea {
        text-align: left;
    }

    .title {
        color: white;
        font-weight: bold;
    }

    .titlebox, .textbox {
        font-size: medium;
        text-align: left;
        border: 1px solid;
        width: 100%;
        color: white;
        background: #5a5a5a;
    }

    .textbox {
        resize: none;
        height: 20rem;
    }

    .formButton {
        margin-top: 1rem;
        text-align: right;
    }

    .postButton {
        border: none;
        background: #5a5a5a;
        color: white;
        font-weight: bold;
        padding: 10px;
    }

    .postButton:hover {
        background-color: #3b3b3b;
    }

    .error {
        color: red;
        font-weight: bold;
    }
</style>