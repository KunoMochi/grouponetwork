import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state: {
    username: '',
    password: '',
    showModal1: false,
    showModal2: false
  },
  getters: {
  },
  mutations: {
    changeModalState (state, payload) {
      // console.log(payload)
      state.showModal1 = payload.showModal1
      state.showModal2 = payload.showModal2
    }
  },
  actions: {
    onSignUp(context, data) {
      let modal1 = false
      let modal2 = false
      if(data.username) {
        this.username = data.username
        if(data.password == data.confPass && data.password != null) {
          this.password = data.password
          // console.log('username: ' + this.username + ', password: ' + this.password)
          axios.post('http://localhost:3000/api/auth/signup', {
              username: this.username,
              password: this.password
            }).catch(err => {
              console.log(err)
            })
        } else {
          modal2 = true
        }
      } else {
        modal1 = true
      }
      context.commit('changeModalState', {showModal1: modal1, showModal2: modal2})
    }
  },
  modules: {
  }
})
