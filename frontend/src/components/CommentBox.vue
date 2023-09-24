<template>
    <div class="comment-box">
        <div class="comment-head"><p class="user">
            <router-link to="/profile">[ Username1234 ]</router-link></p></div>
        <div class="comment-area">This is where the post lives</div>
        <div><p class="time-elapsed">Posted XXXX ago</p></div>
    </div>
</template>

<style lang="scss">

    .user {
        text-align: left;
        font-weight: bold;

        a {
            color: white;
            text-decoration: none;
        }
    }

    .time-elapsed {
        text-align: right;
        font-weight: bold;
    }

    .comment-area {
        margin: 2rem;
        text-align: left;
    }
</style>