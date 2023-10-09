<template>
    <form class="login" v-on:submit.prevent="onLogin({ username: username, password: password})">
        <h1>Welcome back!</h1>
        <div class="username">
            <p><label> Username</label></p>
            <input v-model="username" class="username-box" id="username">
        </div>
        <div class="password">
            <p><label>Password</label></p>
            <input v-model="password" class="password-box" id="password" type="password">
        </div>
        <div class="username-error" v-show="showModal1">
            <p>Username required!</p>
        </div>
        <div class="pass-error" v-show="showModal2">
            <p>Password required!</p>
        </div>
        <div>
            <button type="submit">Login</button> | 
            <router-link to="/signup">Create an account</router-link>
        </div>
    </form>
</template>

<script>
import { mapState, mapActions, mapGetters } from 'vuex'

export default {
    data() {
        return {
            username: this.username,
            password: this.password
        }
    },
    computed: {
        ...mapState(['showModal1','showModal2']),
        ...mapGetters(['getAuth','getUserId'])
    },
    watch: {
        getAuth() {
            this.$router.push('/')
        }
    },
    methods: {
        ...mapActions(['onLogin'])
    }
}
</script>

<style lang="scss" scoped>
    div .login {
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .username, .password {
        font-weight: bold;
        margin-top: 2rem;
    }
    
    input {
        font-size: medium;
        width: 30rem;
    }

    .username-error, .pass-error {
        color: red;
    }

    a {
        font-size: small;
        font-weight: bold;
        color: white;
        text-decoration: none;
    }
</style>