<template>
    <div class="comment-box">
        <div class="comment-head">
            <div class="userId">
                <div><p class="title">Topic Name</p>
                <input class="titlebox"/></div>
            </div>
        </div>
        <div class="commentArea">
            <textarea class="textbox" />
        </div>
        <div class="postbutton"><a href="/post">Create Post</a></div>
    </div>
</template>

<style lang="scss">
    #comment-head {
        display: flex;
        width: 100%;
    }

    .postbutton {
        min-width: fit-content;
        text-align: right;
        font-weight: bold;

        a {
            color: white;
            text-decoration: none;
        }
    }

    .commentArea {
        margin: 2rem;
        text-align: left;
    }

    .title {
        margin: 0 2rem 1rem 2rem;
    }

    .titlebox {
        margin: 0 2rem 0 2rem;
        border: 1px solid;
        width: 80%;
        color: white;
        background: #5a5a5a;
    }

    .textbox {
        border: 1px solid;
        width: 100%;
        height: 30rem;
        color: white;
        background: #5a5a5a;
    }
</style>