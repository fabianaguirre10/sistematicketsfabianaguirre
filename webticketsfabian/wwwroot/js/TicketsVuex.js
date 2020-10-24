
var inicio = 0;
var timeout = 0;
function LoadVueStruct() {

    Vue.component('Init', {
        template: `  <v-flex class="top-movil" xs12>
                        <atender></atender>
                        <cliente></cliente>
                        <infoticket></infoticket>
                       
                     </v-flex>`

    });

    Vue.component('atender', {
        data: function () {
            return {
                count: 0
            };
        },
        template: `    <v-card-text>
                           Actualizar Atención..!!!
                            <div class="box-body">
                                <div class="form-group col-md-6">
                                <input type="button" value="Actualizar"  v-on:click="empezarDetener();">
                             
                                 </div>
                            </div>
                    </v-card-text>
    `,
        methods: {
            ...Vuex.mapActions(['empezarDetener'])

        }
    });
    Vue.component('cliente', {
        data: function () {
            return {
                count: 0
            };
        },
        template: `    <v-card-text>
                            Ingrese nuevo cliente..!!!
                            <div class="box-body">
                                <div class="form-group col-md-6">
                                    IDPERSONA: <input type="text" id="idpersona" class="form-control" > 
                                </div>
                                 <div class="form-group col-md-6">
                                   NOMBRE PERSONA: <input type="text" id="nombre" class="form-control" >
                                </div>
                                <div class="form-group col-md-6">
                                <button class="btn btn-primary" type="button" v-on:click="guardarcliente()">AÑADIR</button>
                                 </div>
                            </div>
                    </v-card-text>
    `,
        methods: {
            ...Vuex.mapActions(['guardarcliente'])
        }
    });
    Vue.component('infoticket', {
        template: `       
            <v-layout row justify-center>
                     
                                 <template v-slot:header>
                                     <div class="body-2 font-weight-black text-xs-center">   Datos de Ticket </div>
                                                   
                                       
                                
                                      </template >
                                    
                                      <v-card color=white>
                                        <v-card-text>
                                          Cola Espera 3 minutos..!!!
                                            <div class="panel panel-warning" v-for="(ticket, i) in info">

                                                <div class="col-sm-3" v-if="ticket.tipocola==3">
                                                    <div>
                                                        {{ticket.persona.idpersona}} -   {{ticket.persona.nombre}}
                                                    </div>
                                                </div>
                                            </div>
                                            Cola Espera 2 minutos..!!!
                                            <div class="panel panel-warning" v-for="(ticket, i) in info">
                                                <div class="col-sm-3" v-if="ticket.tipocola==2">
                                                    <div>
                                                        {{ticket.persona.idpersona}} - {{ticket.persona.nombre}}
                                                    </div>
                                                </div>

                                            </div>    
                                        </v-card-text>
             
                                </v-card>
                                                  
                        
                       
            
                      </v-layout>
                    `,

        computed: {
            info: {
                get() {
                    return this.$store.state.poll;
                }
            }

        },
        methods: {
            formatDate: function (e) {
                let date = new Date(Date.parse(e));
                var options = { year: 'numeric', month: 'long', day: 'numeric' };
                return date.toLocaleDateString("es-ES", options);
            }
        }


    });
    const store = new Vuex.Store({
        state: {
            poll: [],
            idpersona: "",
            nombre: ""

        },
        mutations: {
            Mutationguardarcliente(state, post) {
                if ($("#idpersona").val() !== "" && $("#nombre").val() !== "") {
                    axios({
                        method: 'post', url: '/Tickets/GurdarPersonticket', params: {
                            idpersona: $("#idpersona").val(),
                            nombre: $("#nombre").val()
                        }
                    }).then(function (response) {

                        axios({
                            method: 'get', url: '/Tickets/GetVue', params: {
                            }
                        }).then(function (response) {
                            if (response !== 'notfound') {
                                store.state.poll = response.data;
                                $("#idpersona").val("");
                                $("#nombre").val("");
                            } else {
                                alert("Tiene problemas de red, favor cerrar la plataforma y volver a intentar");
                            }
                        });


                    });
                } else {
                    alert("LLenar campos obligatorios...!!!!");
                }
            },
            async  Reload(state, val) {

                axios({
                    method: 'get', url: '/Tickets/GetVue', params: {
                    }
                }).then(function (response) {
                   if (response !== 'notfound') {
                        store.state.poll = response.data;
                    } else {
                        alert("Tiene problemas de red, favor cerrar la plataforma y volver a intentar");
                    }
                });
            }
            
            
        },
        actions: {
            guardarcliente: function () {
                store.commit('Mutationguardarcliente', { _model: store.state.poll });
            },
            empezarDetener: function () {
                store.commit('Reload', { _model: store.state.poll });
            }
        }
    });
    new Vue({
        el: '#IdVuex',
        store,
        template: `
          <v-app style="    background-color: #eeeeee; !important">
           <Init></Init>
             </v-app>
      `,
        created: function () {

            axios({
                method: 'get', url: '/Tickets/GetVue', params: {

                }
            })
                .then(function (response) {
                    if (response !== 'notfound') {
                        store.state.poll = response.data;
                    } else {
                        alert("Tiene problemas de red, favor cerrar la plataforma y volver a intentar");
                    }
                });
        }

    });
}
