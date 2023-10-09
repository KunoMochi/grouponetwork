<template>
    <nav>
        <div class="logo">
            <img src="../assets/icon-left-font-monochrome-white-long.png" alt="Groupomania">
        </div>
        <div class="spacer">
            <input class="search-box" />
            <button class="search-button">Search</button>
        </div>
        <div class="user-head" v-if="isAuth">
            <router-link to="/profile" class="greet">Hi, {{ username }}!</router-link> | 
            <router-link to="/" class="logout" @click="onLogOut()">Log Out</router-link>
        </div>
        <div v-else class="user-controls">
            <router-link to="/login">Login</router-link> | 
            <router-link to="/signup">Sign up</router-link>
        </div>
    </nav>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
    computed: {
        ...mapState(['isAuth','username']),
        ...mapGetters(['getAuth','getUserId','getUserName'])
    },
    methods: {
        ...mapActions(['onLogOut'])
    }
}
</script>

<style lang="scss">
    nav {
        display: flex;
        text-align: left;
        background-color: #474747;
        padding: 1rem;
        font-weight: bold;
        color: white;
        
        a {
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
    }

    .logo {
        img {
            height: 2em;
        }
    }

    .spacer {
        text-align: right;
        width: 100%;
        padding: 0 1rem 0 1rem;

        .search-box {
            width: 20rem;
        }
    }

    .user-head, .user-controls {
        text-align: right;
        min-width: fit-content;
    }
</style>