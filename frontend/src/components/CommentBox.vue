<template>
    <div class="commentBox" :key="index">
        <div v-show="this.postParentId === null" class="commentTitle">
            <h2>{{ postTitle }}</h2>
        </div>
        <div class="commentHead">
            <span><router-link class="userId" :to="{ name: 'profile', params: { id: postUserId } }">{{ postUsername }}</router-link></span>
            <span class="commentSpacer"></span>
            <span :id="postCommentId" class="commentID" hidden="true">{{ postCommentId }}</span>
        </div>
        <div class="commentArea">
            <textarea v-if="editModal" v-model="content" id="commentText" class="textbox" autocorrect="on"></textarea>
            <div v-else class="comment">{{ tempPostContent }}</div>
        </div>
        <div><p class="timeStamp">Posted {{ formatDate(postTimestamp) }}</p></div>
        <div v-if="postUserId == userId && this.isAllowed" class="commentCtrl">
            <div v-if="editModal">
                <router-link id="submitButton" class="button" to="" @click="onSubmit({ commentid: postCommentId, userid: postUserId, content: content })">Submit</router-link>
                <router-link id="cancelButton" class="button" to="" @click="toggleEdit()">Cancel</router-link>
            </div>
            <div v-else>
                <router-link id="editButton" class="button" to="" @click="toggleEdit(tempPostContent)">Edit</router-link>
                <router-link id="deleteButton" class="button" to="" @click="onDelete({ commentid: postCommentId, userid: postUserId })">Delete</router-link>
            </div>
        </div>
        <div>
            <router-link id="replyButton" class="button" to="" v-if="!replyModal" @click="toggleReply">Reply</router-link>
            <div class="replyCtrl" v-else>
                <div class="replyArea">
                    <textarea v-model="replyContent" id="replyText" class="textbox" autocorrect="on"></textarea>
                </div>
                <router-link id="sendButton" class="button" :to="{ name: 'topic', params: {id: postCommentId } }" @click="onSend({ userId, content: replyContent, timestamp, parentId: postCommentId})">Send</router-link>
                <router-link id="replyButton" class="button" to="" @click="toggleReply">Cancel</router-link>
            </div>
        </div>
        <div class="messages">
            <p class="error">{{ message }}</p>
            <label v-if="query === undefined">Query is empty</label>
        </div>
        <CommentBox class="comment" 
            v-for="(topic, index) in query" 
            :key="index"
            :index="index"
            :postCommentId="topic.CommentID" 
            :postUserId="topic.UserID" 
            :postUsername="topic.UserName" 
            :postTitle="topic.Title" 
            :postContent="topic.PostContent" 
            :postTimestamp="topic.Timestamp"
            :postParentId="this.postCommentId"
            :modal="false"/>
    </div>
</template>

<script setup>
    import CommentBox from '../components/CommentBox.vue'
</script>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'
import axios from 'axios'
import moment from 'moment'

export default {
    props: [
        'index',
        'postCommentId',
        'postUserId',
        'postUsername',
        'postTitle',
        'postContent',
        'postTimestamp',
        'postParentId',
        'modal'],
    data() {
        return {
            tempPostContent: this.postContent,
            editModal: this.modal,
            replyModal: this.modal,
            replyContent: '',
            query: '',
            timestamp: Date(),
            message: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed']),
        ...mapGetters(['getIsAuth','getUserId','getUserName'])
    },
    methods: {
        ...mapActions(['postReply', 'editComment', 'deleteComment', 'resetPage']),
        onSubmit(data) {
            this.editComment(data)
            this.tempPostContent = data.content
            this.editModal = !this.editModal
        },
        onDelete(data) {
            this.deleteComment(data)
            this.resetPage()
            this.$router.push(`/`)
        },
        toggleEdit(data) {
            this.content = data
            this.editModal = !this.editModal
        },
        toggleReply() {
            this.replyModal = !this.replyModal
            this.message = ''
        },
        formatDate (value) {
            if (value) {
                return moment(String(value)).format('MMM DD, yyyy h:mm A')
            }
        },
        onSend({userId, content, timestamp, parentId}) {
            if(this.getIsAuth) {
                if(content != '') {
                    this.postReply({userId, title: null, content, timestamp, images: null, parentId}).then(() => {
                        this.toggleReply()
                        this.replyContent = ''
                        // this.$router.push(`/topic/${this.$route.params.id}`)
                    }).catch(err => {
                        console.log(err)
                    })
                } else {
                    this.message = 'Cannot send empty post!'
                }
            } else {
                this.message = 'Please login before making a post!'
            }
        },
        findChildComments() {
            axios('http://localhost:3000/api/comments/findChildComments/' + this.postCommentId).then((result) => {
                this.query = result.data
                // if(this.query[0])
                //     console.log(this.query[0].CommentID)
            })
        }
    },
    beforeMount() {
        this.findChildComments()
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
        margin: 1rem;
    }

    .commentTitle {
        font-size: large;
        font-weight: bold;
    }

    .commentHead {
        text-align: left;
    }

    .userId {
        font-weight: bold;
        font-size: medium;
        color: white;
        text-decoration: none;
    }

    .commentSpacer {
        width: 100%;
    }

    .commentID {
        text-align: end;
        font-weight: bold;
        color: white;
    }

    .comment {
        margin-left: 2rem;
        font-size: small;
    }

    .timeStamp {
        text-align: end;
        font-weight: bold;
    }

    .commentArea {
        margin: 1rem;
        text-align: left;
    }

    .commentCtrl {
        text-align: right;
    }

    .button {
        padding: 5px 10px;
        margin: 5px;
        background-color: #5a5a5a;
        border: 1px solid #b9b9b9;
        border-radius: 5px;
        text-decoration: none;
        text-align: left;
        font-size: small;
    }

    .replyArea {
        margin: 1rem 2rem;
    }

    .replyCtrl {
        text-align: right;
    }

    a:hover {
        background-color: #3b3b3b;
    }

    .textbox {
        height: 10rem;
        width: 100%;
        resize: none;
        background: #5a5a5a;
        font-size: medium;
        text-align: left;
        border: 1px solid;
        color: white;
    }
    
    .messages {
        text-align: center;
    }

    .error {
        color: red;
        font-weight: bold;
    }
</style>