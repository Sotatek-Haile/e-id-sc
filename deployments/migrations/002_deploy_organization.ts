import { DeployFunction } from "hardhat-deploy/dist/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment): Promise<void> {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  console.log(deployer);

  await deploy("Organization", {
    from: deployer,
    log: true,
    proxy: {
      proxyContract: "OptimizedTransparentProxy",
      owner: deployer,
      execute: {
        methodName: "initialize",
        args: [
          "Organization",
          "Organization",
          "0x7F7A7c61412770e85339582B3a939C0407F0f414"
        ], // change me when deploy production
      },
    },
  });
};

func.tags = ["organization"];
export default func;
