package br.com.techtalk;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Deserializer;
import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.common.serialization.Serializer;

import java.io.IOException;

public class CustomSerdes {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static <T> Serde<T> jsonSerdes(final Class<T> target) {
        return Serdes.serdeFrom(new JsonSerializer<T>(), new JsonDeserializer<T>(target));
    }

    private static class JsonSerializer<T> implements Serializer<T> {

        @Override
        public byte[] serialize(String topic, T data) {
            try {
                return MAPPER.writeValueAsBytes(data);
            } catch (JsonProcessingException exception) {
                exception.printStackTrace();
                System.exit(1);
                // will never reach here ...
                return null;
            }
        }
    }

    private static class JsonDeserializer<T> implements Deserializer<T> {

        final Class<T> target;

        public JsonDeserializer(final Class<T> target) {
            this.target = target;
        }

        @Override
        public T deserialize(String topic, byte[] data) {
            try {
                return MAPPER.readValue(data, target);
            } catch (IOException exception) {
                exception.printStackTrace();
                System.exit(1);
                // Will never reach here ...
                return null;
            }
        }
    }
}


