{
  parts(namespace):: {
    all:: [
      $.parts(namespace).serviceAccount,
      $.parts(namespace).roleBinding,
      $.parts(namespace).role,
      $.parts(namespace).service,
      $.parts(namespace).deploy,
      $.parts(namespace).serviceUi,
      $.parts(namespace).deployUi,
    ],

    serviceAccount: {
      apiVersion: "v1",
      kind: "ServiceAccount",
      metadata: {
        name: "ml-pipeline",
        namespace: namespace,
      },
    },  // service account

    roleBinding:: {
      apiVersion: "rbac.authorization.k8s.io/v1beta1",
      kind: "ClusterRoleBinding",
      metadata: {
        labels: {
          app: "ml-pipeline",
        },
        name: "ml-pipeline",
        namespace: namespace,
      },
      roleRef: {
        apiGroup: "rbac.authorization.k8s.io",
        kind: "ClusterRole",
        name: "ml-pipeline",
      },
      subjects: [
        {
          kind: "ServiceAccount",
          name: "ml-pipeline",
          namespace: namespace,
        },
      ],
    },  // role binding

    role: {
      apiVersion: "rbac.authorization.k8s.io/v1beta1",
      kind: "ClusterRole",
      metadata: {
        labels: {
          app: "ml-pipeline",
        },
        name: "ml-pipeline",
        namespace: namespace,
      },
      rules: [
        {
          apiGroups: [
            "argoproj.io",
          ],
          resources: [
            "workflows",
          ],
          verbs: [
            "create",
            "get",
            "list",
            "watch",
            "update",
            "patch",
          ],
        },
      ],
    },  // role

    service: {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        labels: {
          app: "ml-pipeline",
        },
        name: "ml-pipeline",
        namespace: namespace,
      },
      spec: {
        ports: [
          {
            port: 8888,
            targetPort: 8888,
            protocol: "TCP",
            name: "http",
          },
        ],
        selector: {
          app: "ml-pipeline",
        },
      },
      status: {
        loadBalancer: {}
      },
    }, //service

    deploy: {
    	apiVersion: "apps/v1beta2",
    	kind: "Deployment",
    	metadata: {
    		"labels": {
    			"app": "ml-pipeline",
    		},
    		name: "ml-pipeline",
    	},
    	spec: {
    		selector: {
    			matchLabels: {
    				app: "ml-pipeline",
    			},
    		},
    		template: {
    			metadata: {
    				labels: {
    					app: "ml-pipeline",
    				},
    			},
    			spec: {
    				containers: [
    					{
    						name: "ml-pipeline-api-server",
    						image: "gcr.io/ml-pipeline/api-server",
                ports: [
                    {
                      containerPort: 8888,
                    },
                  ],
    					},
    				],
    				serviceAccountName: "ml-pipeline",
    			},
    		},
    	},
    }, // deploy


    service: {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        labels: {
          app: "ml-pipeline-ui",
        },
        name: "ml-pipeline-ui",
        namespace: namespace,
      },
      spec: {
        ports: [
          {
            port: 80,
            targetPort: 3000,
          },
        ],
        selector: {
          app: "ml-pipeline-ui",
        },
      },
      status: {
        loadBalancer: {}
      },
    }, //serviceUi

    deploy: {
    	apiVersion: "apps/v1beta2",
    	kind: "Deployment",
    	metadata: {
    		"labels": {
    			"app": "ml-pipeline-ui",
    		},
    		name: "ml-pipeline-ui",
    	},
    	spec: {
    		selector: {
    			matchLabels: {
    				app: "ml-pipeline-ui",
    			},
    		},
    		template: {
    			metadata: {
    				labels: {
    					app: "ml-pipeline-ui",
    				},
    			},
    			spec: {
    				containers: [
    					{
    						name: "ml-pipeline-ui",
    						image: "gcr.io/ml-pipeline/api-server",
    						imagePullPolicy: "Always"
                ports: [
                    {
                      containerPort: 3000,
                    },
                  ],
    					},
    				],
    			},
    		},
    	},
    }, // deployUi
  },  // parts
}