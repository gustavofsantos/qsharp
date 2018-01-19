// The Bell states are a concept in quantum information science
// and represent the simplest examples of entanglement.

// documentação das primitivas: 
// https://docs.microsoft.com/en-us/qsharp/api/prelude/microsoft.quantum.primitive?view=qsharp-preview
namespace Quantum.Bell
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	// parâmetros da operação
    operation Set (desired: Result, q1: Qubit) : ()
    {
        body // corpo da operação
        {
            let current = M(q1); // M(): Mede o qubit com base no PauliZ => Zero se o entrelaçamento +1 é observado,
								 //											One  se o entrelaçamento -1 é observado.

			if (desired != current) {
				X(q1); // X(): Operador PauliX (NOT/FLIP) => Retorna nada.
			}
        }
    }

	// => retorna uma tupla de dois inteiros
	operation BellTest (cont: Int, inicial: Result) : (Int,Int) 
	{
		body
		{
			// Q# possui por padrão a criação de variáveis imutáveis, logo se uma variável
			// precisa ter seu dado modificado, deve ser criada usando a palavra 'mutable'
			mutable numUns = 0; // mutable: permite que numUns tenha o valor modificado

			// using: aloca um array de qubits para ser usado ao longo do bloco. Todos os Qubits são
			// alocados e desalocados dinamicamente ao longo do bloco (ler borrowing).
			using (qubits = Qubit[1]) 
			{
				for (teste in 1..cont) 
				{
					Set (inicial, qubits[0]);
					
					let res = M(qubits[0]); // entrelaça o quibit[0]

					// se é medido um |1> então incrementa o contador de vezes
					// que foi medido um One (One é o tipo de Q# para o estado |1>)
					if (res == One) 
					{
						// a palavra 'set' é necessária para indicar que a variável 
						// mutavel 'numUns' terá seu valor modificado
						set numUns = numUns + 1; 
					}
				}
				Set (Zero, qubits[0]);
			}

			// Retorna o numero de vezes que foi medido um |0> e 
			// o numero de vezes que foi medido um |1>
			return (cont - numUns, numUns);
		}
	}
}
