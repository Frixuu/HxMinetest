import lua.Os;
import lua.Table;
import minetest.Minetest;
import minetest.math.NoiseParams;
import minetest.math.PerlinNoiseMap;
import minetest.math.Vector;
import minetest.math.VoxelArea;
import minetest.worldgen.NodeContentBuffer;

/**
    Adapted from https://github.com/paramat/lvm_example/
**/
class ExampleVoxelManip {

    /** 3D noise params for the terrain. **/
    private static var terrainNoiseParams(default, null): NoiseParams;

    private static function __init__() {
        terrainNoiseParams = {
            offset: 0.0,
            scale: 1.0,
            spread: new Vector(384.0, 192.0, 384.0),
            seed: 5900033,
            octaves: 5,
            persistence: 0.63,
            lacunarity: 2.0,
        };
    }

    private static function main() {

        final SANDSTONE = Minetest.getContentId("default:sandstone");
        final WATER = Minetest.getContentId("default:water_source");

        // "Singlenode" mapgen generates air nodes only
        Minetest.setMapgenSetting("mgname", "singlenode");
        // Disable the engine lighting calculation,
        // since it will be done for air, and thus incorrect after we place nodes
        Minetest.setMapgenSetting("flags", "nolight");

        var noiseMap: PerlinNoiseMap = null;
        final noiseBuffer: AnyTable = Table.create();
        final dataBuffer = new NodeContentBuffer();

        Minetest.registerOnGenerated((minp, maxp, _) -> {
            final t0 = Os.clock();
            final sideLength = maxp.x - minp.x + 1;
            final dimensions = new Vector(sideLength, sideLength, sideLength);
            noiseMap ??= new PerlinNoiseMap(terrainNoiseParams, dimensions);
            noiseMap.get3DMapFlat(minp, noiseBuffer);

            final result = Minetest.getMapgenObjectVoxelManip();
            final area = VoxelArea.create(result.emergedMin, result.emergedMax);
            final vm = result.vm;
            vm.getData(dataBuffer);

            var noiseIndex = 1;
            for (z in minp.z...maxp.z + 1) {
                for (y in minp.y...maxp.y + 1) {
                    var vmIndex = area.index(minp.x, y, z);
                    for (x in minp.x...maxp.x + 1) {
                        final densityNoise = noiseBuffer[noiseIndex];
                        final densityGradient = (1 - y) / 128.0;
                        if (densityNoise + densityGradient > 0) {
                            dataBuffer.set(vmIndex, SANDSTONE);
                        } else if (y <= 1) {
                            dataBuffer.set(vmIndex, WATER);
                        }
                        noiseIndex += 1;
                        vmIndex += 1;
                    }
                }
            }

            vm.setData(dataBuffer);
            vm.calcLighting();
            vm.writeToMap();
            vm.updateLiquids();

            final t1 = Os.clock();
            final duration = Math.ceil((t1 - t0) * 1000.0);
            Minetest.log('Mapchunk generated in $duration ms');
        });
    }
}
