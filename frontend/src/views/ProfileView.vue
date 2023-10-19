<template>
    <div class="profile">
        <h1>{{ query.UserName }}'s Profile</h1>
    </div>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
import axios from 'axios'

export default {
    props: ['id'],
    data() {
        return {
            query: ''
        }
    },
    computed: {
        ...mapState(['userId','isAllowed'])
    },
    methods: {
        ...mapMutations([['changeAllowed']]),
        findProfile() {
            axios('http://localhost:3000/api/profiles/findUser/' + this.id).then((result) => {
                console.log(result.data)
                this.query = result.data
            })
        }
    },
    beforeMount() {
        this.findProfile()
        this.$store.commit('changeAllowed', { isAllowed: true })
    },
    beforeUnmount() {
        this.$store.commit('changeAllowed', { isAllowed: false })
    }
}
</script>

<style lang="scss" scoped>
    div {
        width: 100%;
        text-align: center;
        padding: 1rem;
    }
</style>