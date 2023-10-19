<template>
    <form class="commentBox" v-on:submit.prevent="onSubmit({ userId, title, content, timestamp})">
        <div class="commentHead">
            <p class="title">Title</p>
            <input v-model="title" class="titlebox" placeholder="Enter Title"/>
        </div>
        <div class="commentArea">
            <p class="title">Message</p>
            <textarea v-model="content" class="textbox" autocorrect="on" placeholder="Enter Comment"></textarea>
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
        ...mapActions(['postComment', 'resetPage']),
        onSubmit({userId, title, content, timestamp}) {
            this.postComment({userId, title, content, timestamp, parentId: null}).then((result) => {
                if(result)
                    this.$router.push('/topic/' + result.data[0].CommentID)
            }).catch(err => {
                console.log(err)
            })
        }
    }
}
</script>

<style lang="scss" scoped>
    .commentBox {
        max-width: 1000px;
        background-color: #474747;
        border-radius: 5px;
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
        border-radius: 5px;
        color: white;
        font-weight: bold;
        font-size: medium;
        padding: 5px 10px;
    }

    .postButton:hover {
        background-color: #3b3b3b;
    }

    .error {
        color: red;
        font-weight: bold;
    }
</style>