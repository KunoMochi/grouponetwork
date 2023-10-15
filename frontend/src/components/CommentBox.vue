<template>
    <div class="commentBox">
        <div class="commentHead">
            <span><router-link class="userId" to="/profile">[Username1234]</router-link></span>
            <span class="commentSpacer"></span>
            <span class="commentID">24</span>
        </div>
        <div class="commentArea">This is where the post lives</div>
        <div><p class="timeStamp">Posted XXXX ago</p></div>
    </div>
</template>

<style lang="scss" scoped>

    .commentBox {
        max-width: 1000px;
        background-color: #474747;
        padding: 1rem;
    }

    .commentHead {
        text-align: left;
        display: flex;
    }

    .userId {
        font-weight: bold;
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

    .timeStamp {
        text-align: end;
        font-weight: bold;
    }

    .commentArea {
        margin: 2rem;
        text-align: left;
    }
</style>