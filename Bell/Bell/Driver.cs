using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            // aloca dinamicamente um simulador para executar o código quantico
            using (var SIM = new QuantumSimulator())
            {
                Result[] estados_iniciais = new Result[] { Result.Zero, Result.One };

                foreach (Result estado in estados_iniciais)
                {
                    // computa o teste: cont=1000 inicial=estados_iniciais
                    var resp = BellTest.Run(SIM, 1000, estado).Result;

                    var (numZeros, numUns) = resp;

                    System.Console.WriteLine($"Resultado:{estado, -4} 0s={numZeros, -4} 1s={numUns, -4}");
                }
            }
            System.Console.WriteLine("Pressione qualquer tecla para continuar...");
            System.Console.ReadKey();

        }
    }
}