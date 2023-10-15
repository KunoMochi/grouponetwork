<template>
    <form class="login" v-on:submit.prevent="onLogin({ username, password })">
        <h1>Welcome back!</h1>
        <div class="username">
            <p><label> Username</label></p>
            <input v-model="username" class="username-box" id="username">
        </div>
        <div class="password">
            <p><label>Password</label></p>
            <input v-model="password" class="password-box" id="password" type="password">
        </div>
        <div>
            <button type="submit">Login</button> | 
            <router-link to="/signup">Create an account</router-link>
        </div>
        <div class="error">
            <p>{{ errorMessage }}</p>
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
        ...mapState(['errorMessage']),
        ...mapGetters(['getIsAuth','getUserId'])
    },
    watch: {
        getIsAuth() {
            this.$router.push('/')
        }
    },
    methods: {
        ...mapActions(['onLogin', 'resetPage'])
    },
    beforeRouteLeave() {
        this.resetPage()
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

    .error {
        color: red;
        font-weight: bold;
    }

    a {
        font-size: small;
    }
</style>