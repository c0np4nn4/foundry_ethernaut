# Ethernaut problem solving with Foundry

`Foundry`!!!!

---
# FYI
Reference: [ethernaut-x-foundry](https://github.com/ciaranmcveigh5/ethernaut-x-foundry)

---
# how to check solution

```bash
forge test --match-contract <Problem name>Test -vvvv
```

- e.g.
```bash
forge test --match-contract FallbackTest -vvvv
```

---

- deploy_prob.sh (wip)
    - deploy specific problem to the local newtork using `Anvil`
    - deploy **Attacker** contract and interact with it using `Cast`

