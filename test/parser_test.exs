defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  setup_all do
    {:ok,
    arbol: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 2
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol0: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 2
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol1: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 0
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol2: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 100
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol3: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 0002
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol4: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 000
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol5: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 3
            },
            node_name: :logical_negation,
            right_node: nil,
            value: nil
          },
          node_name: :return,
          right_node: nil,
          value: nil
        },
        node_name: :function,
        right_node: nil,
        value: :main
      },
      node_name: :program,
      right_node: nil,
      value: nil
    },
    arbol6: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: %AST{
                      left_node: %AST{
                        left_node: %AST{
                          left_node: %AST{
                            left_node: %AST{
                              left_node: %AST{
                                left_node: %AST{
                                  left_node: nil,
                                  node_name: :constant,
                                  right_node: nil,
                                  value: 6
                            },
                            node_name: :logical_negation,
                            right_node: nil,
                            value: nil
                          },
                          node_name: :negation,
                          right_node: nil,
                          value: nil
                        },
                        node_name: :bitwise_complement,
                        right_node: nil,
                        value: nil
                      },
                      node_name: :bitwise_complement,
                      right_node: nil,
                      value: nil
                    },
                    node_name: :negation,
                    right_node: nil,
                    value: nil
                  },
                  node_name: :logical_negation,
                  right_node: nil,
                  value: nil
                },
                node_name: :logical_negation,
                right_node: nil,
                value: nil
              },
              node_name: :logical_negation,
              right_node: nil,
              value: nil
            },
            node_name: :logical_negation,
            right_node: nil,
            value: nil
          },
          node_name: :logical_negation,
          right_node: nil,
          value: nil
        },
        node_name: :logical_negation,
        right_node: nil,
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol7: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :negation,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol8: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :addition,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},

arbol9: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :multiplication,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol10: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :division,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 3
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol11: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 2
          },
          node_name: :negation,
          right_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 1
              },
              node_name: :multiplication,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: nil
            },
            node_name: :division,
            right_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 1
            },
            value: nil
          },
          value: nil
        },
        node_name: :addition,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 4
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol12: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 2
          },
          node_name: :negation,
          right_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 1
            },
            node_name: :multiplication,
            right_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 3
            },
            value: nil
          },
          value: nil
        },
        node_name: :division,
        right_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 1
          },
          node_name: :addition,
          right_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 4
          },
          value: nil
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol13: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              node_name: :multiplication,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: nil
            },
            node_name: :division,
            right_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 4
            },
            value: nil
          },
          node_name: :addition,
          right_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 8
          },
          value: nil
        },
        node_name: :negation,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 5
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol14: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 2
          },
          node_name: :negation,
          right_node: nil,
          value: nil
        },
        node_name: :addition,
        right_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 3
          },
          node_name: :logical_negation,
          right_node: nil,
          value: nil
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol15: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 3
        },
        node_name: :division,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 0
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol16: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :and,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 7
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol17: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :or,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol18: %AST{left_node: %AST{left_node: %AST{left_node: %AST{left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 2}, node_name: :equal, right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 2}, value: nil}, node_name: :return, right_node: nil, value: nil}, node_name: :function, right_node: nil, value: :main}, node_name: :program, right_node: nil, value: nil},
arbol19: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :not_equal,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol20: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :less_than_or_equal,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol21: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :less_than,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol22: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :greater_than_or_equal,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol23: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 2
        },
        node_name: :greater_than,
        right_node: %AST{
          left_node: nil,
          node_name: :constant,
          right_node: nil,
          value: 9
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol24: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 5
              },
              node_name: :equal,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 5
              },
              value: nil
            },
            node_name: :and,
            right_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 1
              },
              node_name: :not_equal,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 0
              },
              value: nil
            },
            value: nil
          },
          node_name: :and,
          right_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 4
            },
            node_name: :less_than_or_equal,
            right_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 6
            },
            value: nil
          },
          value: nil
        },
        node_name: :and,
        right_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 9
          },
          node_name: :greater_than_or_equal,
          right_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 10
          },
          value: nil
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},
arbol25: %AST{
  left_node: %AST{
    left_node: %AST{
      left_node: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 5
          },
          node_name: :less_than,
          right_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 5
          },
          value: nil
        },
        node_name: :or,
        right_node: %AST{
          left_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 1
          },
          node_name: :greater_than,
          right_node: %AST{
            left_node: nil,
            node_name: :constant,
            right_node: nil,
            value: 0
          },
          value: nil
        },
        value: nil
      },
      node_name: :return,
      right_node: nil,
      value: nil
    },
    node_name: :function,
    right_node: nil,
    value: :main
  },
  node_name: :program,
  right_node: nil,
  value: nil
},

    tupla_error1: {:error, "Error: falta el tipo de valor de retorno", 1,:main_keyword},
    tupla_error2: {:error, "Archivo sin elementos",0,"--"},
    tupla_error3: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", 2, :close_brace},
    tupla_error4: {:error, "Error: falta la función principal main",1,:return_keyword},
    tupla_error5: {:error, "Error: falta el paréntesis abierto",1,:close_paren},
    tupla_error6: {:error, "Error: falta el paréntesis de cierre", 2, {:constant, 2}},
    tupla_error7: {:error, "Error: Hay más elementos después del final de la función",0,"}"},
    tupla_error8: {:error, "Error: programa incompleto", 1, :open_brace},
    tupla_error9: {:error, "Error: falta la llave abierta", 2, :return_keyword},
    tupla_error10: {:error, "Error: falta la llave de cierre",1,:open_brace},
    tupla_error11: {:error, "Error: falta la palabra clave 'return'", 2, {:constant, 2}},
    tupla_error12: {:error, "Error: La expresión del retorno es incorrecta", 2, :semicolon},
    tupla_error13: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", 2, :logical_negation},
    tupla_error14: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", 2, :logical_negation},
    tupla_error15: {:error, "Error: La expresión del retorno es incorrecta", 2, :semicolon},
    tupla_error16: {:error, "Error: falta la llave abierta", 1, :negation},
    tupla_error17: {:error, "Error: La expresión del retorno es incorrecta", 2, :semicolon},
    tupla_error18: {:error, "Error: La expresión del retorno es incorrecta", 2, :multiplication},
    tupla_error19: {:error, "Error: La expresión del retorno es incorrecta", 2, :division},
    tupla_error20: {:error, "Error: La expresión del retorno es incorrecta", 2, :division},
    tupla_error21: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: =>7;", 2}, :error},
    tupla_error22: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: =<5;", 2}, :error},
    tupla_error23: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: =!9;", 2}, :error},
    tupla_error24: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: &2;", 2}, :error},
    tupla_error25: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: |7;", 2}, :error},
    tupla_error26: {:error, "Error: La expresión del retorno es incorrecta", 2, :less_than},
    tupla_error27: {:error, "Error: falta el punto y coma después de la instruccion para finalizar la declaración de retorno", {"Token not valid: =4;", 2}, :error}
  }
  end

test "return 2", state do

  code = """
      int main() {
        return 2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol0]
end

test "return 0", state do
    code = """
      int main() {
        return 0;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol1]
  end

    test "multi_digit", state do
    code = """
      int main() {
        return 100;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol2]
  end

    test "new_lines", state do
    code = """
    int
    main
    (
    )
    {
    return
    2
    ;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

    test "no_newlines", state do
    code = """
    int main(){return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

   test "spaces", state do
    code = """
    int   main    (  )  {   return  2 ; }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol]
  end

 test "elements separated just by spaces", state do
    assert Lexer.scan_words([{"int",0}, {"main(){return",0}, {"2;}",0}]) |> Parser.parse_program() ==
    state[:arbol]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words([{"int",0}, {"main()",0}, {"{return",0}, {"2;}",0}]) |> Parser.parse_program() == state[:arbol]
  end

  test "everything is separated", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"2",0}, {";",0}, {"}",0}]) |> Parser.parse_program() ==
             state[:arbol]
  end

  test "separados", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(){",0}, {"return",0}, {"2",0}, {";}",0}]) |> Parser.parse_program() ==
             state[:arbol]
  end

  test "ceros izquierda", state do
    code = """
      int main() {
        return 0002;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol3]
  end

    test "Multiple ceros", state do
    code = """
      int main() {
        return 000;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol4]
  end



#-----------------------------------


  test "sin int", state do
    code = """
      main main() {
        return 2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error1]
  end

  test "lista de tokens vacia", state do
    code = """
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error2]
  end

  test "sin punto y coma", state do
    code = """
    int main() {
      return 2}
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error3]
  end

  test "tokens en desorden", state do
     code = """
     int return main () {
      return 2; ()
      5 98 int main {}
      return ( 2 )
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error4]
   end

     test "sin ( ", state do
    code = """
      int main) {
      return 2;}
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error5]
  end

  test "Ausencia de tokens", state do
    code = """
      int main(
         2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error6]
  end

    test "Token fuera de rango", state do
    code = """
      int main(){
      return  2;
    } main
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error7]
  end

  test "incompleto", state do
    code = """
      int main(){
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error8]
  end

  test "sin {", state do
    code = """
    int main()
    return  2;
  }
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error9]
  end

  test "sin }", state do
    code = """
    int main(){
    return  2;
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error10]
  end

  test "sin return", state do
    code = """
    int main(){
    2;}
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error11]
  end

  test "sin constante", state do
    code = """
    int main(){
    return  ;}
  """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error12]
  end

#------ Pruebas parte 2 -------

test "return !3", state do

  code = """
      int main() {
        return !3;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol5]
end

test "con varios operadores unarios", state do

  code = """
      int main() {
        return !!!!!!-~~-!6;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol6]
end

test "con operador unario a la derecha del operando", state do

  code = """
      int main() {
        return 2!;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error13]
end

test "constante en medio de operadores unarios", state do

  code = """
      int main() {
        return --8!~;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error14]
end

test "operador unario sin constante", state do

  code = """
      int main() {
        return !;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error15]
end

test "con operadores en desorden", state do

  code = """
      int main() -~ {
        return -2;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error16]
end

#--------Pruebas parte 3-----------

    test "resta", state do
    code = """
    int main() {
    return 2-2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol7]
  end

  test "suma", state do
    code = """
    int main() {
    return 2+2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol8]
  end

  test "multiplicacion", state do
    code = """
    int main() {
    return 2*2;
    }
    """
     s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol9]
  end

  test "division", state do
    code = """
    int main() {
    return 2/3;
    }
    """
     s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol10]
  end

  test "falta constante en operacion binaria", state do
    code = """
    int main() {
    return 2+;
    }
    """

    s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error17]
  
  end 

  test "opraciones binarias sin parentesis", state do
    code = """
    int main() {
    return 2-1*3/1+4;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol11]
  end

  test "opracion binaria con parentesis", state do
    code = """
    int main() {
    return (2-1*3)/(1+4);
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol12]
  end

  test "con todos los operadores", state do
    code = """
    int main() {
    return 2*3/4+8-5;
    }
    """
     s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol13]
  end


  test "opracion binaria y unaria", state do
    code = """
    int main() {
    return (-2)+(!3);
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol14]
  end


  test "repeticion de un operador binario", state do
    code = """
    int main() {
      return 8**9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error18]
  end


  test "opracion binaria incompleta", state do
    code = """
    int main() {
      return /7/;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error19]
  end
  
  test "division entre cero", state do
    code = """
    int main() {
      return 3/0;
    }
    """
     s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol15]
  end


  test "oprador binario sin constantes", state do
    code = """
    int main() {
      return /;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error20]
  end

#------Pruebas parte 4---------

  test "operacion &&", state do
    code = """
    int main() {
    return 2&&7;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol16]
  end
  test "operacion ||", state do
    code = """
    int main() {
    return 2||2;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol17]
  end
  test "operacion ==", state do
    code = """
    int main() {
    return 2==2;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol18]
  end
  test "operacion !=", state do
    code = """
    int main() {
    return 2!=2;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol19]
  end
 
  test "operacion <=", state do
    code = """
    int main() {
    return 2<=2;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol20]
  end
  
  test "operacion <", state do
    code = """
    int main() {
    return 2<2;
    }
    """
     s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol21]
  end
  
  test "opracion >=", state do
    code = """
    int main() {
    return 2>=2;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol22]
  end
  
  test "operacion >", state do
    code = """
    int main() {
    return 2>9;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol23]
  end

  test "Operador <= incorrecto", state do
    code = """
    int main() {
    return 8=>7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error21]
  end

  test "Operador >= incorrecto", state do
    code = """
    int main() {
    return 4=<5;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error22]
  end

  test "Operador != incorrecto", state do
    code = """
    int main() {
    return 6=!9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error23]
  end

  test "Operador && incorrecto", state do
    code = """
    int main() {
    return 7&2;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error24]
  end

  test "Operador || incorrecto", state do
    code = """
    int main() {
    return 8|7;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error25]
  end

  test "Operador < incorrecto", state do
    code = """
    int main() {
    return 1<<<9;
    }
    """
  s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error26]
  end

  test "Operador == incorrecto", state do
    code = """
    int main() {
    return 5=4;
    }
    """
 s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:tupla_error27]
  end

  
  test "con paréntesis y espacios entre operandos", state do
    code = """
    int main() {
    return (5==5) && (1!=0) && (4<=6) && (9>=10);
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol24]
  end

   test "operacion binaria sin paréntesis", state do
    code = """
    int main() {
    return 5<5||1>0;
    }
    """
      s_code = Sanitizer.sanitize_source(code)
    assert Lexer.scan_words(s_code) |> Parser.parse_program() == state[:arbol25]
  end



 end
