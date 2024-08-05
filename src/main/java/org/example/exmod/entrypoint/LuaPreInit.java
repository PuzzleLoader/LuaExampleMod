package org.example.exmod.entrypoint;

import com.github.puzzle.annotations.LuaEntrypointVariant;
import com.github.puzzle.loader.entrypoint.interfaces.PreModInitializer;
import org.luaj.vm2.LuaValue;

@LuaEntrypointVariant(variantOf = PreModInitializer.class)
public class LuaPreInit implements PreModInitializer {

    LuaValue value;

    public LuaPreInit(LuaValue value) {
        this.value = value;
    }

    @Override
    public void onPreInit() {
        value.call();
    }
}
