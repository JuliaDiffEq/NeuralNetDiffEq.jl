using Test, Flux
using Plots
using DiffEqDevTools
using DiffEqBase, NeuralNetDiffEq

# Homogeneous
f(du, u, p, t) = -du+6*u
tspan = ([0.0f0], [2.0f0])
u0 = [1.0f0]
du0 = [0.0f0]
dt = 1/20f0
prob = SecondOrderODEProblem(f, u0, du0, tspan)
chain = Chain(Dense(1,5,σ),Dense(5,1))
opt = ADAM(0.1, (0.9, 0.95))
sol = solve(prob, NeuralNetDiffEq.NNODE2(chain,opt), dt=dt, verbose = true, abstol=1e-10, maxiters = 200)

t = tspan[1]:dt:tspan[2]
an_sol = @. 1/5 * exp(-3*t) *(3*exp(5*t)+2.0)

plot(an_sol, sol, title="Second Order Linear ODE", label=["Analytical","Numerical"], lw=3)
xlabel!("t")
ylabel!("y(t)")
