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
import { mapState, mapGetters, mapActions, mapMutations } from 'vuex'
import axios from 'axios'

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
        ...mapActions(['resetPage']),
        ...mapMutations(['changeMessage']),
        onSubmit({userId, title, content, timestamp}) {
            if(this.getIsAuth) {
                console.log(this.getIsAuth)
                if(content && title) {
                axios.post('http://localhost:3000/api/comments/addComment', {
                    userId: userId,
                    title: title,
                    postContent: content,
                    timestamp: timestamp,
                    images: null,
                    parentId: null,
                    rootId: null
                }).then((result) => {
                    console.log(result)
                    if(result) {
                        console.log(result.data[0].CommentID)
                        this.$router.push('/topic/' + result.data[0].CommentID)
                    }
                }).catch(err => {
                    console.log(err)
                })
                } else {
                this.changeMessage({message: 'Please fill in title and comment fields!'})
                }
            } else {
                this.changeMessage({message: 'Please log in before making a post!'})
            }
        }
    }
}
</script>

<style lang="scss" scoped>
    .commentBox {
        max-width: 800px;
        background-color: #474747;
        border: 1px solid #7c7c7c;
        border-radius: 5px;
        padding: 1rem;
    }

    .commentHead, .commentArea {
        text-align: left;
        // border: 1px solid white;
    }

    .title {
        color: white;
        font-weight: bold;
    }

    .titlebox, .textbox {
        font-size: medium;
        text-align: left;
        border: 1px solid #7c7c7c;
        border-radius: 5px;
        padding: 5px;
        width: 98%;
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
        border: 1px solid #b9b9b9;
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